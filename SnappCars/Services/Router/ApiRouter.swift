//
//  ApiRouter.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
  
  case getCarResults(carQuery:SnappCarQuery)
  
  // MARK: - HTTPMethod
  private var method: HTTPMethod {
    switch self {
    case .getCarResults:
      return .get
    }
  }
  
  // MARK: - Path
  private var path: String {
    switch self {
    case .getCarResults:
      return ApiConstants.Server.searchUrlExtension
    }
  }
  
  // MARK: - Parameters
  private var parameters: Parameters? {
    switch self {
    case .getCarResults(let carQuery):
      return carQuery.toDictionary()
    }
  }
  
  // MARK: - URLRequestConvertible
  func asURLRequest() throws -> URLRequest {
    let url = try ApiConstants.Server.baseURL.asURL()
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    urlRequest.httpMethod = method.rawValue
    return try URLEncoding.default.encode(urlRequest as URLRequestConvertible, with: parameters)
  }
}
