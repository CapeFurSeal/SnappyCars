//
//  ApiResult.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation

struct ApiResult<T> {
  var message: String?
  var value: T?
  var rawRequest: Foundation.URLRequest?
  var rawResponse: URLResponse?
  var statusCode: Int?
  
  init(
    message: String?,
    rawRequest: Foundation.URLRequest? = nil,
    rawResponse: URLResponse? = nil,
    statusCode: Int? = nil,
    value:T?
    ) {
    self.message = message
    self.rawRequest = rawRequest
    self.rawResponse = rawResponse
    self.statusCode = statusCode
    self.value = value
  }
}
