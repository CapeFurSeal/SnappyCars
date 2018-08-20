//
//  SnappCar.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/16/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import ObjectMapper

internal struct SnappCar: Mappable {
  var ci: String?
  var user: User?
  var priceInformation: PriceInformation?
  var car: Car?
  var flags: Flags?

  init?(map: Map) {
  }
  
  mutating internal func mapping(map: Map) {
    ci <- map["ci"]
    car <- map["car"]
    flags <- map["flags"]
    priceInformation <- map["priceInformation"]
    user <- map["user"]
  }
}
