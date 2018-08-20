//
//  SnappCarResult.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import ObjectMapper

internal struct SnappCarResult: Mappable {
  var results = [SnappCar]()
  var sums: Sums?
  
  init?(map: Map) {
  }
  
  mutating internal func mapping(map: Map) {
    results <- map["results"]
    sums <- map["sums"]
  }
}
