//
//  API+FineDust.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

import SWXMLHash

protocol APIFineDustType: APIType {
  
  /// 측정소 정보 조회.
  ///
  /// - Parameters:
  ///   - pageNo: 페이지 인덱스.
  ///   - numOfRows: 한 페이지에 노출되는 정보량.
  ///   - completion: 컴플리션 핸들러.
  func fetchObservatory(pageNumber pageNo: Int,
                        numberOfRows numOfRows: Int,
                        completion: @escaping (ObservatoryResponse?, Error?) -> Void)
  
  /// 미세먼지 농도 조회.
  ///
  /// - Parameters:
  ///   - dataTerm: 데이터 기간. daily 또는 month.
  ///   - pageNo: 페이지 인덱스.
  ///   - numOfRows: 한 페이지에 노출되는 정보량.
  ///   - completion: 컴플리션 핸들러.
  func fetchFineDustConcentration(term dataTerm: DataTerm,
                                  pageNumber pageNo: Int,
                                  numberOfRows numOfRows: Int,
                                  completion: @escaping (FineDustResponse?, Error?) -> Void)
}

/// 미세먼지 API 관련 API 정의.
extension API: APIFineDustType {
  
  func fetchObservatory(pageNumber pageNo: Int = 1,
                        numberOfRows numOfRows: Int = 1,
                        completion: @escaping (ObservatoryResponse?, Error?) -> Void) {
    let urlString = baseURL
      .appending("/MsrstnInfoInqireSvc/getNearbyMsrstnList")
      .appending("?tmX=\(LocationInfo.shared.x)")
      .appending("&tmY=\(LocationInfo.shared.y)")
      .appending("&numOfRows=\(numOfRows)")
      .appending("&pageNo=\(pageNo)")
      .appending("&serviceKey=\(serviceKey)")
    guard let url = URL(string: urlString) else { return }
    Network.request(url, method: .get) { data, httpStatusCode, error in
      // HTTP 통신의 상태 코드가 200인지 확인. 그렇지 않으면 HTTP 에러를 발생시켜 넘겨줌.
      guard httpStatusCode == .success else {
        completion(nil, httpStatusCode?.error)
        return
      }
      // 데이터가 있는지 확인. 그렇지 않으면 넘어온 에러를 넘겨줌.
      guard let data = data else {
        completion(nil, error)
        return
      }
      let xml = SWXMLHash.config { config in
        config.detectParsingErrors = true
      }
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
  
  func fetchFineDustConcentration(term dataTerm: DataTerm,
                                  pageNumber pageNo: Int = 1,
                                  numberOfRows numOfRows: Int = 24,
                                  completion: @escaping (FineDustResponse?, Error?) -> Void) {
    let observatory = FineDustInfo.shared.observatory.percentEncoded
    let urlString = baseURL
      .appending("/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty")
      .appending("?stationName=\(observatory)")
      .appending("&dataTerm=\(dataTerm.rawValue)")
      .appending("&pageNo=\(pageNo)")
      .appending("&numOfRows=\(numOfRows)")
      .appending("&serviceKey=\(serviceKey)")
      .appending("&ver=1.1")
    guard let url = URL(string: urlString) else { return }
    Network.request(url, method: .get) { data, httpStatusCode, error in
      // HTTP 통신의 상태 코드가 200인지 확인. 그렇지 않으면 HTTP 에러를 발생시켜 넘겨줌.
      guard httpStatusCode == .success else {
        completion(nil, httpStatusCode?.error)
        return
      }
      // 데이터가 있는지 확인. 그렇지 않으면 넘어온 에러를 넘겨줌.
      guard let data = data else {
        completion(nil, error)
        return
      }
      let xml = SWXMLHash.config { config in
        config.detectParsingErrors = true
      }
      let parsed = xml.parse(data)
      do {
        let response: FineDustResponse = try parsed.value()
        // 미세먼지 응답 코드가 00인지 확인. 그렇지 않으면 응답 코드에 따른 에러를 발생시켜 넘겨줌.
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
