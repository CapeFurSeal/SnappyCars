//
//  RequestManager.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RequestManager {
  
  fileprivate static let encodingKey = "accept"
  fileprivate static let sessionConfiguration = URLSessionConfiguration.default
  fileprivate static let serverTrustPolicies:[String: ServerTrustPolicy] = [
    ApiConstants.Server.baseURL: .disableEvaluation
  ]
  static var requestManager = SessionManager()
 
  static func configureAPIManager(apiKey: String) {
    let manager = SessionManager(configuration: sessionConfiguration)
    requestManager = manager
  }

  static func generateRequestForURL(URL:Foundation.URL) -> URLRequest {
    let mutableURLRequest = URLRequest(url: URL)
    return mutableURLRequest
  }
 
  static func request<T>(route:URLRequestConvertible, responseHandler:ResponseHandler,
                      statusCodeRange:Range<Int>,
                      onSuccess:@escaping ((ApiResult<T>)->()),
                      onFailure:@escaping ((SnappCarError?)->())) {
    requestManager.request(route).responseJSON { (response) in
      guard response.response != nil else {
        onFailure(responseHandler.handleErrors(response))
        return
      }
      guard response.result.error == nil else {
        onFailure(responseHandler.handleErrors(response))
        return
      }
      if statusCodeRange.contains(response.response!.statusCode) ||
        statusCodeRange.lowerBound == response.response?.statusCode {
        onSuccess(responseHandler.handleResponseData(response))
      } else {
        onFailure(responseHandler.handleErrors(response))
        return
      }
    }
  }
}
