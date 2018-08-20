//
//  CountryTableViewCell.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/19/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
  
  @IBOutlet fileprivate weak var countryLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func setupCell(country:Country) {
    countryLabel.textColor = UIColor.snappCarSubTextGrey
    countryLabel.font = UIFont.systemFont(ofSize: 18)
    countryLabel.textAlignment = .left
    countryLabel.text = "\(country)"
  }
}
