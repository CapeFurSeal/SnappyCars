//
//  ResultSums.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import ObjectMapper

internal struct Sums: Mappable {
  var totalResults: Int?
  
  init?(map: Map) {
  }
  
  mutating internal func mapping(map: Map) {
    totalResults <- map["totalResults"]
  }
}
