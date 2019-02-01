//
//  API.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

import SWXMLHash

/// Dust Manager.
final class DustManager: DustManagerType {
  
  let networkManager: NetworkManagerType
  
  init(networkManager: NetworkManagerType = NetworkManager.shared) {
    self.networkManager = networkManager
  }
  
  // MARK: Property
  
  /// Base URL.
  let baseURL = "http://openapi.airkorea.or.kr/openapi/services/rest"
  /// Service Key.
  let serviceKey = """
  BfJjA4%2BuaBHhfAzyF2Ni6xoVDaf%2FhsZylifmFKdW3kyaZECH6c2Lua05fV%2F%2BYgbzPBaSl0YLZwI%2BW%2FK2xzO7sw%3D%3D
  """
  
  func fetchObservatory(numberOfRows numOfRows: Int = 1,
                        pageNumber pageNo: Int = 1,
                        completion: @escaping (ObservatoryResponse?, Error?) -> Void) {
    let urlString = baseURL
      .appending("/MsrstnInfoInqireSvc/getNearbyMsrstnList")
      .appending("?tmX=\(SharedInfo.shared.x)")
      .appending("&tmY=\(SharedInfo.shared.y)")
      .appending("&numOfRows=\(numOfRows)")
      .appending("&pageNo=\(pageNo)")
      .appending("&serviceKey=\(serviceKey)")
    guard let url = URL(string: urlString) else { return }
    networkManager.request(url,
                           method: .get,
                           parameters: nil,
                           headers: [:]) { data, httpStatusCode, error in
      guard httpStatusCode == .success else {
        completion(nil, httpStatusCode?.error)
        return
      }
      // 데이터가 있는지 확인. 그렇지 않으면 넘어온 에러를 넘겨줌.
      guard let data = data else {
        completion(nil, error)
        return
      }
      let xml = SWXMLHash.config { $0.detectParsingErrors = true }
      let parsed = xml.parse(data)
      do {
        // 미세먼지 응답 코드가 00인지 확인. 그렇지 않으면 응답 코드에 따른 에러를 발생시켜 넘겨줌.
        let response: ObservatoryResponse = try parsed.value()
        guard response.statusCode == .success else {
          completion(nil, response.statusCode.error)
          return
        }
        completion(response, nil)
      } catch let error as XMLDeserializationError {
        switch error {
        case let .implementationIsMissing(method):
          completion(nil, XMLError.implementationIsMissing(method))
        case let .nodeIsInvalid(node):
          completion(nil, XMLError.nodeIsInvalid(node))
        case .nodeHasNoValue:
          completion(nil, XMLError.nodeHasNoValue)
        case let .typeConversionFailed(type, node):
          completion(nil, XMLError.typeConversionFailed(type, node))
        case let .attributeDoesNotExist(node, attribute):
          completion(nil, XMLError.attributeDoesNotExist(node, attribute))
        case let .attributeDeserializationFailed(type, attribute):
          completion(nil, XMLError.attributeDeserializationFailed(type, attribute))
        }
      } catch {
        completion(nil, XMLError.default)
      }
    }
  }
  
  func fetchDustInfo(term dataTerm: DataTerm,
                     numberOfRows numOfRows: Int,
                     pageNumber pageNo: Int = 1,
                     completion: @escaping (DustResponse?, Error?) -> Void) {
    let observatory = SharedInfo.shared.observatory.percentEncoded
    let urlString = baseURL
      .appending("/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty")
      .appending("?stationName=\(observatory)")
      .appending("&dataTerm=\(dataTerm.rawValue)")
      .appending("&pageNo=\(pageNo)")
      .appending("&numOfRows=\(numOfRows)")
      .appending("&serviceKey=\(serviceKey)")
      .appending("&ver=1.1")
    guard let url = URL(string: urlString) else { return }
    networkManager.request(url,
                           method: .get,
                           parameters: nil,
                           headers: [:]) { data, httpStatusCode, error in
      guard httpStatusCode == .success else {
        completion(nil, httpStatusCode?.error)
        return
      }
      // 데이터가 있는지 확인. 그렇지 않으면 넘어온 에러를 넘겨줌.
      guard let data = data else {
        completion(nil, error)
        return
      }
      let xml = SWXMLHash.config { $0.detectParsingErrors = true }
      let parsed = xml.parse(data)
      do {
        let response: DustResponse = try parsed.value()
        guard response.statusCode == .success else {
          completion(nil, response.statusCode.error)
          return
        }
        completion(response, nil)
      } catch let error as XMLDeserializationError {
        switch error {
        case let .implementationIsMissing(method):
          completion(nil, XMLError.implementationIsMissing(method))
        case let .nodeIsInvalid(node):
          completion(nil, XMLError.nodeIsInvalid(node))
        case .nodeHasNoValue:
          completion(nil, XMLError.nodeHasNoValue)
        case let .typeConversionFailed(type, node):
          completion(nil, XMLError.typeConversionFailed(type, node))
        case let .attributeDoesNotExist(node, attribute):
          completion(nil, XMLError.attributeDoesNotExist(node, attribute))
        case let .attributeDeserializationFailed(type, attribute):
          completion(nil, XMLError.attributeDeserializationFailed(type, attribute))
        }
      } catch {
        completion(nil, XMLError.default)
      }
    }
  }
}
