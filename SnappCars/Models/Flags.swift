//
//  CarFlags.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import ObjectMapper

internal struct Flags: Mappable {
  var favorite: Bool?
  var new: Bool?
  var instantBookable: Bool?
  var previouslyRented: Bool?
  var isKeyless: Bool?
  
  init?(map: Map) {
  }
  
  mutating internal func mapping(map: Map) {
    favorite <- map["favorite"]
    new <- map["new"]
    instantBookable <- map["instantBookable"]
    previouslyRented <- map["previouslyRented"]
    isKeyless <- map["isKeyless"]
  }
}
