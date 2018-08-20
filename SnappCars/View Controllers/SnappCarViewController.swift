//
//  SnappCarViewController.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import UIKit

class SnappCarViewController: BaseViewController {
  
  @IBOutlet fileprivate weak var snappCarTableView: UITableView!
  fileprivate let resultsPresenter = ResultPresenter()
  fileprivate var resultsToDisplay: SnappCarResult?
  fileprivate var snappCarQuery: SnappCarQuery?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resultsPresenter.attachView(self)
    self.getResults()
    self.setupNavigation(navigationTitle: "Find Ride")
    self.setupTableview()
    self.setupNavButtons()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func getResults() {
    self.snappCarQuery = SnappCarQuery(country: .Netherlands,
                                       sortType: .Distance,
                                       order: .Ascending,
                                       limit: 10,
                                       offset: 1)
    guard let query = self.snappCarQuery else { return }
    resultsPresenter.getResults(carQuery:query, fetchMoreResults: false)
  }
  
  func setupNavButtons() {
    self.chooseCountryButton.addTarget(self, action: #selector(self.chooseCountry(sender:)), for: .touchUpInside)
    self.sortByButton.addTarget(self, action: #selector(self.showSortActions(sender:)), for: .touchUpInside)
    let sortButton = UIBarButtonItem(customView: self.sortByButton)
    let countryButton = UIBarButtonItem(customView: self.chooseCountryButton)
    self.navigationItem.rightBarButtonItems = [sortButton,countryButton]
    
    
  }
}

extension SnappCarViewController: UITableViewDataSource, UITableViewDelegate {
  // MARK: - Tableview delegate Methods
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DataStore().returnResultsCount(result: self.resultsToDisplay)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier:"SnappCarTableViewCell", for: indexPath)
      as? SnappCarTableViewCell {
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.setupCell(result:self.resultsToDisplay?.results[indexPath.row])
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
  fileprivate func setupTableview() {
    UITableView.setupAppTableview(tableview: self.snappCarTableView,
                                  delegate: self,
                                  dataSource: self,
                                  prefetchDataSource: self,
                                  backGroundColor: UIColor.clear,
                                  allowsMultipleSelection: false,
                                  contentInset:UIEdgeInsets(top: 0,
                                                            left: 0,
                                                            bottom: 40,
                                                            right: 0))
  }
}

// MARK: - UITableViewDataSourcePrefetching
extension SnappCarViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    self.checkForMoreResults(indexPaths: indexPaths)
  }
  
  func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
  }
  
  fileprivate func checkForMoreResults(indexPaths:[IndexPath]) {
    if DataStore().needsFetching(indexPaths: indexPaths, result: self.resultsToDisplay) == true {
      resultsPresenter.fetchMoreResults(pageOffset:
        self.resultsToDisplay?.results.count,
                                        query: self.snappCarQuery)
    }
  }
}

extension SnappCarViewController: ResultView {
  func startLoading() {
    self.startActivityIndicator()
  }
  
  func finishLoading() {
    self.stopActivityIndicator()
  }
  
  func setEmptyResults() {
    self.presentAlertController(withTitle: "No Results", message:"There are no results for this query.")
  }
  
  func setResults(snappCarResult:SnappCarResult?, fetchMoreResults:Bool) {
    // dump(snappCarResult)
    guard let snappCarResults = snappCarResult?.results else { return }
    if fetchMoreResults == true {
      self.resultsToDisplay?.results.append(contentsOf:snappCarResults)
      DispatchQueue.main.async {
        self.snappCarTableView.reloadData()
      }
    } else {
      self.resultsToDisplay = snappCarResult
      DispatchQueue.main.async {
        self.snappCarTableView.reloadData()
      }
    }
  }
  
  func resultsError(error: SnappCarError) {
    self.presentAlertController(withTitle:
      error.errorTitle ?? "You got me!",
                                message:
      error.message ?? "There was an error and something went horribly wrong!")
  }
}

extension SnappCarViewController {
  @objc func showSortActions(sender:UIButton!) {
    var actions: [(String, UIAlertActionStyle)] = []
    actions.append((SortType.Recommended.rawValue.capitalized, UIAlertActionStyle.default))
    actions.append((SortType.Distance.rawValue.capitalized, UIAlertActionStyle.default))
    actions.append((SortType.Price.rawValue.capitalized, UIAlertActionStyle.default))
    actions.append(("Cancel", UIAlertActionStyle.cancel))
    self.showActionsheet(viewController: self, title: "Sort By", message: "Sort the list by choosing an option.", actions: actions) { (index, sortType) in
      if index != 3 {
        self.snappCarQuery?.setSortType(sortType:SortType(rawValue: sortType.lowercased())!)
        guard let query = self.snappCarQuery else { return }
        self.resultsPresenter.getResults(carQuery:query, fetchMoreResults: false)
      }
    }
  }
}

extension SnappCarViewController: CountryViewControllerDelegate {
  @objc func chooseCountry(sender:UIButton!) {
    self.performSegue(withIdentifier:"findRideToCountries", sender: self)
  }
  
  func didPickCountry(country:Country) {
    self.snappCarQuery?.setCountry(country: country)
    guard let query = self.snappCarQuery else { return }
    self.resultsPresenter.getResults(carQuery:query, fetchMoreResults: false)
  }
  
  // MARK: Prepare for segue delegate
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "findRideToCountries" {
      if let countryVc = segue.destination as? CountryViewController {
        countryVc.countryDelegate = self
      }
    }
  }
}
