//
//  BaseViewController.swift
//  SnappCars
//
//  Created by Blake Loizides on 7/29/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  internal var sortByButton = AppBounceButton()
  internal var chooseCountryButton = AppBounceButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupSortButton()
    self.setupCountryButton()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func setupNavigation(navigationTitle:String) {
    self.navigationItem.title = navigationTitle
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.largeTitleTextAttributes =
      [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 40), NSAttributedStringKey.foregroundColor:UIColor.snappCarBlue]
    navigationController?.navigationBar.titleTextAttributes =
      [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor:UIColor.snappCarBlue]
    navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor:UIColor.snappCarBlue], for: UIControlState.normal)
    navigationController?.navigationBar.tintColor = UIColor.snappCarBlue
  }
  
  internal func setupSortButton() {
    sortByButton.setImage(UIImage(named: "sortByButton"), for: .normal)
    sortByButton.setImage(UIImage(named: "sortByButton"), for: .highlighted)
    sortByButton.setImage(UIImage(named: "sortByButton"), for: .selected)
    sortByButton.setImage(UIImage(named: "sortByButton"), for: .focused)
    sortByButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    sortByButton.adjustsImageWhenHighlighted = false
    sortByButton.backgroundColor = UIColor.clear
  }
  
  internal func setupCountryButton() {
    chooseCountryButton.setImage(UIImage(named: "chooseCountryButton"), for: .normal)
    chooseCountryButton.setImage(UIImage(named: "chooseCountryButton"), for: .highlighted)
    chooseCountryButton.setImage(UIImage(named: "chooseCountryButton"), for: .selected)
    chooseCountryButton.setImage(UIImage(named: "chooseCountryButton"), for: .focused)
    chooseCountryButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    chooseCountryButton.adjustsImageWhenHighlighted = false
    chooseCountryButton.backgroundColor = UIColor.clear
  }
}
