//
//  SnappCarQuery.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation

class SnappCarQuery {
  
  fileprivate var country:String?
  fileprivate var sortType:String?
  fileprivate var order:String?
  fileprivate var limit:Int?
  fileprivate var offset:Int?
  fileprivate var geo:SnappCarGeoQuery?

  internal func toDictionary() -> [String: AnyObject] {
    var dict:[String: AnyObject] = [String: AnyObject]()
    if let country = country {dict["country"] = country as AnyObject?}
    if let sortType = sortType {dict["sort"] = sortType as AnyObject?}
    if let order = order {dict["order"] = order as AnyObject?}
    if let limit = limit {dict["limit"] = limit as AnyObject?}
    if let offset = offset {dict["offset"] = offset as AnyObject?}
    if let lat = geo?.lat {dict["lat"] = lat as AnyObject?}
    if let lng = geo?.lng {dict["lng"] = lng as AnyObject?}
    if let maxDistance = geo?.maxDistance {dict["max-distance"] = maxDistance as AnyObject?}
    return dict
  }
  
  internal func setPageOffSet(offset:Int) {
    self.offset = offset
  }
  
  internal func setSortType(sortType:SortType) {
    self.sortType = sortType.rawValue
  }
  
  internal func setCountry(country:Country) {
    self.country = country.rawValue
  }
  
  internal init(
    country: Country,
    sortType: SortType? = nil,
    order: Order? = nil,
    geo: SnappCarGeoQuery? = nil,
    limit: Int? = nil,
    offset: Int? = nil
    ){
    
    self.country = Country(rawValue:country.rawValue)?.rawValue
    if let selectedSortType = sortType?.rawValue {
      self.sortType = SortType(rawValue:selectedSortType)?.rawValue
    }
    if let selectedOrder = order?.rawValue {
      self.order = Order(rawValue:selectedOrder)?.rawValue
    }
    self.limit = limit
    self.offset = offset
    self.geo = geo
  }
}
