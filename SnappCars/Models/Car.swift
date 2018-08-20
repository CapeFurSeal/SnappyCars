//
//  Car.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import ObjectMapper

internal struct Car: Mappable {
  var fuelType: String?
  var createdAt: String?
  var year: Int?
  var gear: String?
  var bodyType: String?
  var make: String?
  var model: String?
  var seats: Int?
  var ownerId: String?
  var reviewCount: Int?
  var allowed = [String]()
  var accessories = [String]()
  var images = [String]()
  
  init?(map: Map) {
  }
  
  mutating internal func mapping(map: Map) {
    fuelType <- map["fuelType"]
    createdAt <- map["createdAt"]
    year <- map["year"]
    gear <- map["gear"]
    make <- map["make"]
    model <- map["model"]
    seats <- map["seats"]
    ownerId <- map["ownerId"]
    reviewCount <- map["reviewCount"]
    allowed <- map["allowed"]
    accessories <- map["accessories"]
    images <- map["images"]
  }
}
