//
//  SnappCarError.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import ObjectMapper

internal struct SnappCarError: Mappable {
  var errorTitle: String?
  var message: String?

  init?(map: Map) {
  }
  
  mutating internal func mapping(map: Map) {
    errorTitle <- map["error"]
    message <- map["message"]
  }
}
