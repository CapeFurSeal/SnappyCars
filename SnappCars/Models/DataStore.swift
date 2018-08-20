//
//  DataStore.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/18/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation

struct DataStore {
  internal func needsFetching(indexPaths:[IndexPath],
                                 result:SnappCarResult?) -> Bool {
    guard let results = result?.results.count else {
      return false
    }
    for index in indexPaths {
      if index.row == results - 1 {
        guard let totalResults = result?.sums?.totalResults else {
          return false
        }
        if totalResults > results {
          return true
        }
      }
    }
    return false
  }
  
  internal func returnResultsCount(result:SnappCarResult?) -> Int {
    guard let resultsCount = result?.results.count else {
      return 0
    }
    return resultsCount
  }
}
