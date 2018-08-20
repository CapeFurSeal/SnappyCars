//
//  User.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import ObjectMapper

internal struct User: Mappable {
  var firstName: String?
  var imageUrl: String?
  var street: String?
  var city: String?
  
  init?(map: Map) {
  }
  
  mutating internal func mapping(map: Map) {
    firstName <- map["firstName"]
    imageUrl <- map["imageUrl"]
    street <- map["street"]
    city <- map["city"]
  }
}
