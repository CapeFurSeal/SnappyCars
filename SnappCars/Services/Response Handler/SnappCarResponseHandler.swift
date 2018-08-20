//
//  ArticleResponseHandler.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum ResponseHandler_SnappCarResults: ResponseHandler {
  
  case getResults

  var description: String {
    switch self {
    case .getResults:
      return ".getResults"
    }
  }
  
  func handleResponseData<T>(_ response:DataResponse<Any>) -> ApiResult<T> {
    switch self {
    case .getResults:
      return ApiResult(
        message: "Success!.",
        rawRequest: response.request,
        rawResponse: response.response,
        statusCode: response.response?.statusCode,
        value: extractResults(response))
   }
  }
  
  func handleErrors(_ response:DataResponse<Any>) -> SnappCarError? {
    guard let errorDict = response.result.value as? [String: AnyObject] else {return nil}
    return Mapper<SnappCarError>().map(JSON: errorDict)
  }
  
  fileprivate func extractResults<T>(_ response:DataResponse<Any>) -> T? {
    var newResults: SnappCarResult?
    guard let dict = response.value as? [String:AnyObject] else {
      return newResults as? T
    }
    newResults = Mapper<SnappCarResult>().map(JSON: dict)
    //newResults.append(results!)
    return newResults as? T
  }
}
