//
//  RequestManager_SnappCarResultExtension.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation

extension RequestManager {
  struct CarResults {
    internal func getCarResults<T>(usingQuery query:SnappCarQuery ,
                   onSuccess:@escaping ((ApiResult<T>)->()),
                   onFailure:@escaping ((SnappCarError?)->())) {
      RequestManager.request(route:ApiRouter.getCarResults(carQuery: query),
                             responseHandler: ResponseHandler_SnappCarResults.getResults,
                             statusCodeRange: 200..<300,
                             onSuccess: { (result:ApiResult<T>) in
                              onSuccess(result)
      }) { (errors) in
        onFailure(errors)
      }
    }
  }
}
