//
//  ResponseHandler.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import Alamofire

protocol ResponseHandler {
  func handleResponseData<T>(_ response:DataResponse<Any>) -> ApiResult<T>
  func handleErrors(_ response:DataResponse<Any>) -> SnappCarError?
}
