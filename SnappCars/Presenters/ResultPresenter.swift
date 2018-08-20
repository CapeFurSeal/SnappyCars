//
//  ResultPresenter.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation

protocol ResultView: NSObjectProtocol {
  func startLoading()
  func finishLoading()
  func setEmptyResults()
  func setResults(snappCarResult: SnappCarResult?, fetchMoreResults:Bool)
  func resultsError(error:SnappCarError)
}

class ResultPresenter {
  weak fileprivate var resultView : ResultView?
  fileprivate var isFetchingNextPage = false
  
  internal func attachView(_ view:ResultView){
    resultView = view
  }
  
  internal func detachView() {
    resultView = nil
  }

  internal func getResults(carQuery:SnappCarQuery, fetchMoreResults:Bool) {
    self.isFetchingNextPage = true
    if fetchMoreResults == false {
      self.resultView?.startLoading()
    }
    RequestManager.CarResults().getCarResults(usingQuery: carQuery,
                                          onSuccess: { (result: ApiResult<(SnappCarResult)>) in
                                            if let results = result.value {
                                              self.resultView?.finishLoading()
                                              if results.results.count == 0 {
                                                self.resultView?.setEmptyResults()
                                                return
                                              }
                                              self.resultView?.setResults(snappCarResult: results, fetchMoreResults:fetchMoreResults)
                                              self.isFetchingNextPage = false
                                            }
    }) { (error) in
      guard let error = error else {
        return
      }
      self.isFetchingNextPage = false
      self.resultView?.resultsError(error:error)
      self.resultView?.finishLoading()
    }
  }
  
  internal func fetchMoreResults(pageOffset:Int?, query:SnappCarQuery?) {
    guard let pageOffset = pageOffset else { return }
    guard !isFetchingNextPage else { return }
    guard let query = query else { return }
    query.setPageOffSet(offset: pageOffset + 1)
    self.getResults(carQuery:query, fetchMoreResults:true)
  }
}
