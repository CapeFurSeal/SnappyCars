//
//  PriceInformation.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import ObjectMapper

internal struct PriceInformation: Mappable {
  var price: Double?
  var pricePerKilometer: Int?
  var freeKilometersPerDay: Int?
  var isoCurrencyCode: String?
  
  init?(map: Map) {
  }
  
  mutating internal func mapping(map: Map) {
    price <- map["price"]
    pricePerKilometer <- map["pricePerKilometer"]
    freeKilometersPerDay <- map["freeKilometersPerDay"]
    isoCurrencyCode <- map["isoCurrencyCode"]
  }
}
