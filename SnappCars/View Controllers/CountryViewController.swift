//
//  ChooseCountryTableViewController.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/19/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import UIKit

protocol CountryViewControllerDelegate {
  func didPickCountry(country:Country)
}

class CountryViewController: BaseViewController {
  
  @IBOutlet fileprivate weak var countryTableView: UITableView!
  fileprivate var countries = [Country]()
  internal var countryDelegate: CountryViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigation(navigationTitle: "Select Country")
    self.setupTableview()
    self.countries = [.Denmark,.Germany,.Sweden,.Netherlands]
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension CountryViewController: UITableViewDataSource, UITableViewDelegate {
  // MARK: - Tableview delegate Methods
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier:"CountryTableViewCell", for: indexPath)
      as? CountryTableViewCell {
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.setupCell(country:self.countries[indexPath.row])
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    countryDelegate?.didPickCountry(country: self.countries[indexPath.row])
    self.navigationController?.popViewController(animated: true)
  }
  
  fileprivate func setupTableview() {
    UITableView.setupAppTableview(tableview: self.countryTableView,
                                  delegate: self,
                                  dataSource: self,
                                  backGroundColor: UIColor.clear,
                                  allowsMultipleSelection: false,
                                  contentInset:UIEdgeInsets(top: 0,
                                                            left: 0,
                                                            bottom: 40,
                                                            right: 0))
  }
}
