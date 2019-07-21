//
//  GeoConverter.swift
//  GeoConverter
//
//  Created by SangwooLee on 2017. 7. 27..
//  Copyright © 2017년 sangwoo. All rights reserved.
//
import Foundation

struct GeographicPoint {
  let x: Double   // longitude (경도)
  let y: Double   // latitude (위도)
  let z: Double
  
  init(x: Double, y: Double, z: Double) {
    self.x = x
    self.y = y
    self.z = z
  }
  
  init(x: Double, y: Double) {
    self.x = x
    self.y = y
    self.z = 0
  }
  
  init() {
    self.x = 0
    self.y = 0
    self.z = 0
  }
}

struct NisMapInfo {
  let re: Double      = 6371.00877    // 사용할 지구 반경 [km]
  let grid: Double    = 5.0           // 격자 간격 [km]
  let slat1: Double   = 30.0          // 표준 위도 [degree]
  let slat2: Double   = 60.0          // 표준 위도 [degree]
  let olon: Double    = 126.0         // 기준점의 경도 [degree]
  let olat: Double    = 38.0          // 기준점의 위도 [degree]
  let xo: Double      = 210 / 5.0     // 기준점의 X 좌표 [격자 거리]
  let yo: Double      = 675 / 5.0     // 기준점의 Y 좌표 [격자 거리]
}

enum MapProjectionType {
  case WGS_84
  case KATEC  // TM128
  case TM
  case GRS_80
  case UTMK
  case GRID   // for NIA Open API
}

fileprivate enum DatumParam: Double {
  case X = -146.43
  case Y = 507.89
  case Z = 681.46
}

fileprivate struct GeographicCoordinateData {
  let mapProjectionType: MapProjectionType
  let scaleFactor: Double
  let longitudeCenter: Double
  let latitudeCenter: Double
  let falseNorthing: Double
  let falseEasting: Double
  let major: Double
  let minor: Double
  let es: Double
  let esp: Double
  let ind: Double
  let sourceM: Double
  let destinationM: Double
  
  init(mapProjectionType: MapProjectionType, scaleFactor: Double, longitudeCenter: Double, latitudeCenter: Double,
       falseNorthing: Double, falseEasting: Double, major: Double, minor: Double) {
    self.mapProjectionType = mapProjectionType
    self.scaleFactor = scaleFactor
    self.longitudeCenter = longitudeCenter
    self.latitudeCenter = latitudeCenter
    self.falseNorthing = falseNorthing
    self.falseEasting = falseEasting
    self.major = major
    self.minor = minor
    
    let x = (minor / major)
    es = 1.0 - x * x
    esp = es / (1.0 - es)
    ind = es < 0.00001 ? 1.0 : 0.0
    
    sourceM = major * GeographicCoordinateData.mlfn(
      e0: GeographicCoordinateData.e0fn(es),
      e1: GeographicCoordinateData.e1fn(es),
      e2: GeographicCoordinateData.e2fn(es),
      e3: GeographicCoordinateData.e3fn(es),
      phi: latitudeCenter)
    destinationM = major * GeographicCoordinateData.mlfn(
      e0: GeographicCoordinateData.e0fn(es),
      e1: GeographicCoordinateData.e1fn(es),
      e2: GeographicCoordinateData.e2fn(es),
      e3: GeographicCoordinateData.e3fn(es),
      phi: latitudeCenter)
  }
  
  static func e0fn(_ x: Double) -> Double {
    return 1.0 - 0.25 * x * (1.0 + x / 16.0 * (3.0 + 1.25 * x))
  }
  
  static func e1fn(_ x: Double) -> Double {
    return 0.375 * x * (1.0 + 0.25 * x * (1.0 + 0.46875 * x))
  }
  
  static func e2fn(_ x: Double) -> Double {
    return 0.05859375 * x * x * (1.0 + 0.75 * x)
  }
  
  static func e3fn(_ x: Double) -> Double {
    return x * x * x * (35.0 / 3072.0)
  }
  
  static func mlfn(e0: Double, e1: Double, e2: Double, e3: Double, phi: Double) -> Double {
    return e0 * phi - e1 * sin(2.0 * phi) + e2 * sin(4.0 * phi) - e3 * sin(6.0 * phi)
  }
  
  static func asinz(_ value: Double) -> Double {
    if abs(value) > 1 {
      return asin(value > 0 ? 1 : -1)
    }
    
    return asin(value)
  }
}

class GeoConverter {
  enum converterError: Error {
    case infinity
  }
  
  fileprivate let geoCoordDatas: [MapProjectionType: GeographicCoordinateData]
  fileprivate let espln: Double = 0.0000000001
  
  init() {
    geoCoordDatas = [
      .WGS_84: GeographicCoordinateData(mapProjectionType: .WGS_84, scaleFactor: 1, longitudeCenter: 0.0, latitudeCenter: 0.0, falseNorthing: 0.0, falseEasting: 0.0, major: 6378137.0, minor: 6356752.3142),
      
      .KATEC: GeographicCoordinateData(mapProjectionType: .KATEC, scaleFactor: 0.9999 /* 0.9996 */, longitudeCenter: 2.23402144255274 /* 2.22529479629277 */, latitudeCenter: 0.663225115757845, falseNorthing: 600000.0, falseEasting: 400000.0, major: 6377397.155, minor: 6356078.9633422494),
      
      .TM: GeographicCoordinateData(mapProjectionType: .TM, scaleFactor: 1,
                                    //                longitudeCenter: 2.21656815003280, // 127
        longitudeCenter: 2.21661859489671, // 127 + 10.485 minute
        latitudeCenter: 0.663225115757845, falseNorthing: 500000.0, falseEasting: 200000.0, major: 6377397.155, minor: 6356078.9633422494),
      
      .GRS_80: GeographicCoordinateData(mapProjectionType: .GRS_80, scaleFactor: 1, longitudeCenter: 2.21656815003280, latitudeCenter: 0.663225115757845, falseNorthing: 500000.0, falseEasting: 200000.0, major: 6378137, minor: 6356752.3142),
      
      .UTMK: GeographicCoordinateData(mapProjectionType: .UTMK, scaleFactor: 0.9996, longitudeCenter: 2.22529479629277, latitudeCenter: 0.663225115757845, falseNorthing: 2000000.0, falseEasting: 1000000.0, major: 6378137, minor: 6356752.3141403558)]
  }
  
  func convert(sourceType: MapProjectionType, destinationType: MapProjectionType, geoPoint: GeographicPoint) -> GeographicPoint? {
    let sourcePoint = ({ () -> GeographicPoint? in
      if sourceType == .WGS_84 {
        return GeographicPoint(x: degreeToRadian(geoPoint.x), y: degreeToRadian(geoPoint.y))
      } else {
        return tmToGeodetic(source: sourceType, inputPoint: geoPoint)
      }
      
    })()
    
    guard sourcePoint != nil else {
      return nil
    }
    
    let destinationPoint = ({ () -> GeographicPoint? in
      if destinationType == .WGS_84 {
        return GeographicPoint(x: radianToDegree(sourcePoint!.x), y: radianToDegree(sourcePoint!.y))
      } else {
        return geodeticToTm(destination: destinationType, inputPoint: sourcePoint!)
      }
    })()
    
    guard destinationPoint != nil else {
      return nil
    }
    
    return destinationPoint
  }
  
  func getDistanceByWGS84(from: GeographicPoint, to: GeographicPoint) -> Double {
    let fromLatitude = degreeToRadian(from.y)
    let fromLongitude = degreeToRadian(from.x)
    let toLatitude = degreeToRadian(to.y)
    let toLongitude = degreeToRadian(to.x)
    
    let longitude = toLongitude - fromLongitude
    let latitude = toLatitude - fromLatitude
    
    let a = pow(sin(latitude / 2), 2) + cos(fromLatitude) * cos(toLatitude) * pow(sin(longitude / 2), 2)
    
    return 6376.5 * 2 * atan2(sqrt(a), sqrt(1 - a))
  }
  
  // GeographicPoint.x : longitude, GeographicPoint.y : latitude
  func wgs84ToGrid(_ point: GeographicPoint) -> GeographicPoint? {
    let mapInfo = NisMapInfo()
    let pi = asin(1.0) * 2.0
    let degRad = pi / 180.0
    let re = mapInfo.re / mapInfo.grid
    let slat1 = mapInfo.slat1 * degRad
    let slat2 = mapInfo.slat2 * degRad
    let olon = mapInfo.olon * degRad
    let olat = mapInfo.olat * degRad
    var sn = tan(pi * 0.25 + slat2 * 0.5) / tan(pi * 0.25 + slat1 * 0.5)
    sn = log(cos(slat1) / cos(slat2)) / log(sn)
    var sf = tan(pi * 0.25 + slat1 * 0.5)
    sf = pow(sf, sn) * cos(slat1) / sn
    var ro = tan(pi * 0.25 + olat * 0.5)
    ro = re * sf / pow(ro, sn)
    
    var ra = tan(pi * 0.25 + point.y * degRad * 0.5)
    ra = re * sf / pow(ra, sn)
    var theta = point.x * degRad - olon;
    if theta > pi {
      theta -= 2.0 * pi
    } else if theta < -pi {
      theta += 2.0 * pi
    }
    theta *= sn
    
    let wgs84Point = GeographicPoint(x: (ra * sin(theta)) + mapInfo.xo, y: (ro - ra * cos(theta)) + mapInfo.yo)
    
    return GeographicPoint(x: floor(wgs84Point.x + 1.5), y: floor(wgs84Point.y + 1.5))
  }
  
  private func getDistanceByKatec(from: GeographicPoint, to: GeographicPoint) -> Double? {
    return getDistanceByFromType(fromType: .KATEC, from: from, to: to)
  }
  
  private func getDistanceByTM(from: GeographicPoint, to: GeographicPoint) -> Double? {
    return getDistanceByFromType(fromType: .TM, from: from, to: to)
  }
  
  private func getDistanceByUTMK(from: GeographicPoint, to: GeographicPoint) -> Double? {
    return getDistanceByFromType(fromType: .UTMK, from: from, to: to)
  }
  
  private func getDistanceByGRS80(from: GeographicPoint, to: GeographicPoint) -> Double? {
    return getDistanceByFromType(fromType: .GRS_80, from: from, to: to)
  }
  
  
  private func getDistanceByFromType(fromType: MapProjectionType, from: GeographicPoint, to: GeographicPoint) -> Double? {
    let fromPoint = convert(sourceType: fromType, destinationType: .WGS_84, geoPoint: from)
    let toPoint = convert(sourceType: fromType, destinationType: .WGS_84, geoPoint: to)
    
    guard fromPoint != nil && toPoint != nil else {
      return nil
    }
    
    return getDistanceByWGS84(from: fromPoint!, to: toPoint!)
  }
  
  private func getTimeBySec(distance: Double) -> Int {
    return Int(round(3600 * distance / 4))
  }
  
  private func getTimeByMin(distance: Double) -> Int {
    return Int(ceil(Double(getTimeBySec(distance: distance)) / 60))
  }
  
  private func geodeticToTm(destination: MapProjectionType, inputPoint: GeographicPoint) -> GeographicPoint? {
    let transformedPoint = transform(source: .WGS_84, destination: destination, geoPoint: inputPoint)
    guard transformedPoint != nil else {
      return nil
    }
    
    let deltaLongitude = transformedPoint!.x - geoCoordDatas[destination]!.longitudeCenter
    let sinForInputPointY = sin(transformedPoint!.y)
    let cosForInputPointY = cos(transformedPoint!.y)
    
    if 0 != geoCoordDatas[destination]!.ind {
      let b = cosForInputPointY * sin(deltaLongitude)
      if abs(abs(b) - 1) < espln {
        return nil  // 무한대 에러
      }
    }
    
    let al = cosForInputPointY * deltaLongitude
    let als = al * al
    let c = geoCoordDatas[destination]!.esp * cosForInputPointY * cosForInputPointY
    let tq = tan(transformedPoint!.y)
    let t = tq * tq
    let con = 1 - geoCoordDatas[destination]!.es * sinForInputPointY * sinForInputPointY
    let n = geoCoordDatas[destination]!.major / sqrt(con)
    let ml = geoCoordDatas[destination]!.major *
      GeographicCoordinateData.mlfn(
        e0: GeographicCoordinateData.e0fn(geoCoordDatas[destination]!.es),
        e1: GeographicCoordinateData.e1fn(geoCoordDatas[destination]!.es),
        e2: GeographicCoordinateData.e2fn(geoCoordDatas[destination]!.es),
        e3: GeographicCoordinateData.e3fn(geoCoordDatas[destination]!.es),
        phi: transformedPoint!.y)
    
    let x = geoCoordDatas[destination]!.scaleFactor * n * al * (1 + als / 6 * (1 - t + c + als / 20 * (5 - 18 * t + t * t + 72 * c - 58 * geoCoordDatas[destination]!.esp))) + geoCoordDatas[destination]!.falseEasting
    let y = geoCoordDatas[destination]!.scaleFactor * (ml - geoCoordDatas[destination]!.destinationM + n * tq * (als * (0.5 + als / 24 * (5 - t + 9 * c + 4 * c * c + als / 30 * (61 - 58 * t + t * t + 600 * c - 330 * geoCoordDatas[destination]!.esp))))) + geoCoordDatas[destination]!.falseNorthing
    
    return GeographicPoint(x: x, y: y)
  }
  
  private func tmToGeodetic(source: MapProjectionType, inputPoint: GeographicPoint) -> GeographicPoint? {
    let newPoint = GeographicPoint(
      x: inputPoint.x - geoCoordDatas[source]!.falseEasting,
      y: inputPoint.y - geoCoordDatas[source]!.falseNorthing)
    let maxIter = 6
    let con = (geoCoordDatas[source]!.sourceM + newPoint.y / geoCoordDatas[source]!.scaleFactor) / geoCoordDatas[source]!.major
    
    func calculatePhi(value: Double, count: Int) -> Double? {
      let deltaPhi = ((con + GeographicCoordinateData.e1fn(geoCoordDatas[source]!.es) * sin(2 * value) - GeographicCoordinateData.e2fn(geoCoordDatas[source]!.es) * sin(4 * value) + GeographicCoordinateData.e3fn(geoCoordDatas[source]!.es) * sin(6 * value)) / GeographicCoordinateData.e0fn(geoCoordDatas[source]!.es)) - value
      let phi = value + deltaPhi
      
      if abs(deltaPhi) <= espln {
        return phi
      } else if count >= maxIter {
        return nil  // 무한대 에러
      }
      
      return calculatePhi(value: phi, count: count + 1)
    }
    
    let phi = calculatePhi(value: con, count: 0)
    if phi == nil {
      return nil
    }
    
    let pointForInd = ({ () -> GeographicPoint? in
      if 0 != geoCoordDatas[source]!.ind {
        let f = exp(inputPoint.x / geoCoordDatas[source]!.major * geoCoordDatas[source]!.scaleFactor)
        let g = 0.5 * (f - 1 / f)
        let temp = geoCoordDatas[source]!.latitudeCenter + inputPoint.y / (geoCoordDatas[source]!.major * geoCoordDatas[source]!.scaleFactor)
        let h = cos(temp)
        let con = sqrt((1 - h * h) / (1 + g * g))
        let y = temp < 0 ? -(GeographicCoordinateData.asinz(con)) : GeographicCoordinateData.asinz(con)
        let x = 0 == g && 0 == h ? geoCoordDatas[source]!.longitudeCenter :
          atan(g / h) + geoCoordDatas[source]!.longitudeCenter
        
        return GeographicPoint(x: x, y: y)
      } else {
        return nil
      }})()
    
    let pointForPhi = ({ () -> GeographicPoint? in
      if abs(phi!) < Double.pi / 2 {
        let sinPhi = sin(phi!)
        let cosPhi = cos(phi!)
        let tanPhi = tan(phi!)
        let c = geoCoordDatas[source]!.esp * cosPhi * cosPhi
        let cs = c * c
        let t = tanPhi * tanPhi
        let ts = t * t
        let cont = 1 - geoCoordDatas[source]!.es * sinPhi * sinPhi
        let n = geoCoordDatas[source]!.major / sqrt(cont)
        let r = n * (1 - geoCoordDatas[source]!.es) / cont
        let d = newPoint.x / (n * geoCoordDatas[source]!.scaleFactor)
        let ds = d * d
        let x = geoCoordDatas[source]!.longitudeCenter + (d * (1 - ds / 6 * (1 + 2 * t + c - ds / 20 * (5 - 2 * c + 28 * t - 3 * cs + 8 * geoCoordDatas[source]!.esp + 24 * ts))) / cosPhi)
        let partA = n * tanPhi * ds / r
        let partB = 61 + 90 * t + 298 * c + 45 * ts - 252 * geoCoordDatas[source]!.esp - 3 * cs
        let y = phi! - partA * (0.5 - ds / 24 * (5 + 3 * t + 10 * c - 4 * cs - 9 * geoCoordDatas[source]!.esp - ds / 30 * partB))
        
        return GeographicPoint(x: x, y: y)
      } else {
        let x = geoCoordDatas[source]!.longitudeCenter
        let y = Double.pi * 0.5 * sin(newPoint.y)
        
        return GeographicPoint(x: x, y: y)
      }})()
    
    if let point = pointForInd {
      return transform(source: source, destination: .WGS_84, geoPoint: point)
    } else if let point = pointForPhi {
      return transform(source: source, destination: .WGS_84, geoPoint: point)
    }
    
    return nil
  }
  
  private func geodeticToGeocentric(type: MapProjectionType, inputPoint: GeographicPoint) -> GeographicPoint? {
    /*
     * The function geodeticToGeocentric converts geodetic coordinates
     * (latitude, longitude, and height) to geocentric coordinates (X, Y, Z),
     * according to the current ellipsoid parameters.
     *
     * GeographicPoint
     *    X : Geodetic latitude in radians                     (input)
     *    Y : Geodetic longitude in radians                    (input)
     *    X : Geodetic height, in meters                       (input)
     *
     * GeographicPoint
     *    X : Calculated Geocentric X coordinate, in meters    (output)
     *    Y : Calculated Geocentric Y coordinate, in meters    (output)
     *    Z : Calculated Geocentric Z coordinate, in meters    (output)
     */
    
    /*
     ** Don't blow up if Latitude is just a little out of the value
     ** range as it may just be a rounding issue.  Also removed longitude
     ** test, it should be wrapped by Math.cos() and Math.sin().  NFW for PROJ.4, Sep/2001.
     */
    func getLatitude(x: Double) -> Double? {
      if x < -helfPI && x > -1.001 * helfPI {
        return -helfPI
      } else if x > helfPI && x <  1.001 * helfPI {
        return helfPI
      } else if x < -helfPI || x > helfPI {
        return nil  // x out of range
      } else {
        return x
      }
    }
    
    let latitude = getLatitude(x: inputPoint.y)
    if latitude == nil {
      return nil
    }
    
    let longitude = inputPoint.x > Double.pi ? inputPoint.x - Double.pi * 2 : inputPoint.x
    let height = inputPoint.z
    let sinLatitude = sin(latitude!)
    let cosLatitude = cos(latitude!)
    let rn = geoCoordDatas[type]!.major / sqrt(1.0e0 - geoCoordDatas[type]!.es * pow(sinLatitude, 2))
    
    let outputPoint = GeographicPoint(
      x: (rn + height) * cosLatitude * cos(longitude),
      y: (rn + height) * cosLatitude * sin(longitude),
      z: (rn * (1 - geoCoordDatas[type]!.es) + height) * sinLatitude)
    
    return outputPoint
  }
  
  /** Convert_Geocentric_To_Geodetic
   * The method used here is derived from 'An Improved Algorithm for
   * Geocentric to Geodetic Coordinate Conversion', by Ralph Toms, Feb 1996
   */
  private func geocentricToGeodetic(type: MapProjectionType, inputPoint: GeographicPoint) -> GeographicPoint {
    // square of distance from Z axis
    let W2 = inputPoint.x * inputPoint.x + inputPoint.y * inputPoint.y
    
    // distance from Z axis
    let W = sqrt(W2)
    
    // initial estimate of vertical component
    let T0 = inputPoint.z * adC
    
    // initial estimate of horizontal component
    let S0 = sqrt(T0 * T0 + W2)
    
    // Math.sin(B0), B0 is estimate of Bowring aux doubleiable
    let sinB0 = T0 / S0
    
    // Math.cos(B0)
    let cosB0 = W / S0
    
    // cube of Math.sin(B0)
    let sin3B0 = sinB0 * sinB0 * sinB0
    
    // corrected estimate of vertical component
    let T1 = inputPoint.z + geoCoordDatas[type]!.minor * geoCoordDatas[type]!.esp * sin3B0
    
    // numerator of Math.cos(phi1)
    let sum = W - geoCoordDatas[type]!.major * geoCoordDatas[type]!.es * cosB0 * cosB0 * cosB0
    
    // corrected estimate of horizontal component
    let s1 = sqrt(T1 * T1 + sum * sum)
    
    // Math.sin(phi1), phi1 is estimated latitude
    let sinP1 = T1 / s1
    
    // Math.cos(phi1)
    let cosP1 = sum / s1
    
    // Earth radius at location
    let rn = geoCoordDatas[type]!.major / sqrt(1.0 - geoCoordDatas[type]!.es * sinP1 * sinP1)
    
    // indicates location is in polar region
    let atPole = inputPoint.x == 0 && inputPoint.y == 0 ? true : false
    
    let longitude = ({ () -> Double in
      if inputPoint.x != 0 {
        return atan2(inputPoint.y, inputPoint.x)
      } else {
        if inputPoint.y > 0 {
          return helfPI
        } else if inputPoint.y < 0 {
          return -helfPI
        } else {
          return 0
        }
      }
    })()
    
    let latitude = ({ () -> Double in
      if inputPoint.x == 0 && inputPoint.y == 0 && inputPoint.z == 0 {
        return helfPI
      } else if atPole == false {
        return atan(sinP1 / cosP1)
      }
      
      if inputPoint.x == 0 && inputPoint.y == 0 {
        if inputPoint.z > 0 {
          return helfPI
        } else if inputPoint.z < 0 {
          return -helfPI
        }
      }
      
      return 0
    })()
    
    let height = ({ () -> Double in
      if inputPoint.x == 0 && inputPoint.y == 0 && inputPoint.z == 0 {
        return -self.geoCoordDatas[type]!.minor
      }
      
      if cosP1 >= self.cos67p5 {
        return W / cosP1 - rn
      } else if cosP1 <= -self.cos67p5 {
        return W / -cosP1 - rn
      } else {
        return inputPoint.z / sinP1 + rn * (self.geoCoordDatas[type]!.es - 1)
      }
    })()
    
    let outputPoint = GeographicPoint(
      x: longitude,
      y: latitude,
      z: height)
    
    return outputPoint
  }
  
  private func geodeticToWGS84(_ geoPoint: GeographicPoint) -> GeographicPoint {
    return GeographicPoint(x: geoPoint.x + DatumParam.X.rawValue,
                           y: geoPoint.y + DatumParam.Y.rawValue,
                           z: geoPoint.z + DatumParam.Z.rawValue)
  }
  
  private func geodeticFromWGS84(_ geoPoint: GeographicPoint) -> GeographicPoint {
    return GeographicPoint(x: geoPoint.x - DatumParam.X.rawValue,
                           y: geoPoint.y - DatumParam.Y.rawValue,
                           z: geoPoint.z - DatumParam.Z.rawValue)
  }
  
  private func transform(source: MapProjectionType, destination: MapProjectionType, geoPoint: GeographicPoint) -> GeographicPoint? {
    guard source != destination else {
      return nil
    }
    
    if (source == .KATEC || source == .TM) || (destination == .KATEC || destination == .TM) {
      // Convert to geocentric coordinates.
      if let point = geodeticToGeocentric(type: source, inputPoint: geoPoint) {
        // Convert between datums
        
        let pointAddedWGS84 = ({ () -> GeographicPoint? in
          if source == .KATEC || source == .TM {
            return geodeticToWGS84(point)
          } else {
            return nil
          }
        })()
        
        let newPoint = ({ () -> GeographicPoint? in
          if destination == .KATEC || destination == .TM {
            return geodeticFromWGS84(pointAddedWGS84 == nil ? point : pointAddedWGS84!)
          } else {
            return nil
          }
        })()
        
        // Convert back to geodetic coordinates
        if let point = newPoint {
          return geocentricToGeodetic(type: destination, inputPoint: point)
        } else if let point = pointAddedWGS84 {
          return geocentricToGeodetic(type: destination, inputPoint: point)
        } else {
          return nil
        }
      } else {
        return nil
      }
    } else {
      return nil
    }
  }
  
  private func degreeToRadian(_ degree: Double) -> Double {
    return degree * Double.pi / 180
  }
  
  private func radianToDegree(_ radian: Double) -> Double {
    return radian * 180 / Double.pi
  }
  
  private let helfPI = 0.5 * Double.pi
  private let cos67p5 = 0.38268343236508977   // cosine of 67.5 degrees
  private let adC = 1.0026000
}
