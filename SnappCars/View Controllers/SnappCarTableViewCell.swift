//
//  SnappCarTableViewCell.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import UIKit
import Kingfisher

class SnappCarTableViewCell: UITableViewCell {
  
  @IBOutlet fileprivate weak var priceLabel: UILabel!
  @IBOutlet fileprivate weak var vehicleMakeModelLabel: UILabel!
  @IBOutlet fileprivate weak var vehicleYearLabel: UILabel!
  @IBOutlet fileprivate weak var freeKmLabel: UILabel!
  @IBOutlet fileprivate weak var userImageView: UIImageView!
  @IBOutlet fileprivate weak var vehicleImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.backgroundColor = UIColor.white
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    vehicleImageView.backgroundColor = UIColor.snappCarBlue
    vehicleImageView.image = nil
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  internal func setupCell(result:SnappCar?) {
    userImageView.layer.cornerRadius = userImageView.frame.size.width/2
    userImageView.clipsToBounds = true
    userImageView.layer.borderWidth = 1.0
    userImageView.contentMode = .scaleAspectFill
    userImageView.backgroundColor = UIColor.snappCarOrange
    userImageView.layer.borderColor = UIColor.snappCarOrange.cgColor
    if let imageUrl = result?.user?.imageUrl {
      let url = URL(string: imageUrl)!
      userImageView.kf.setImage(with: url)
    }
    
    vehicleImageView.layer.cornerRadius = vehicleImageView.frame.size.width/2
    vehicleImageView.clipsToBounds = true
    vehicleImageView.layer.borderWidth = 1.0
    vehicleImageView.contentMode = .scaleAspectFill
    vehicleImageView.backgroundColor = UIColor.snappCarBlue
    vehicleImageView.layer.borderColor = UIColor.snappCarBlue.cgColor
    if let imageUrl = result?.car?.images.first {
      let url = URL(string: imageUrl)!
      vehicleImageView.kf.setImage(with: url)
    }
    
    vehicleMakeModelLabel.textColor = UIColor.snappCarTextGrey
    vehicleMakeModelLabel.font = UIFont.boldSystemFont(ofSize: 18)
    vehicleMakeModelLabel.textAlignment = .left
    if let make = result?.car?.make, let model = result?.car?.model {
      vehicleMakeModelLabel.text = "\(make) \(model)"
    }
    
    priceLabel.textColor = UIColor.snappCarSubTextGrey
    priceLabel.font = UIFont.systemFont(ofSize: 14)
    priceLabel.textAlignment = .left
    
    // I could have used a String extension for this
    let currencyAtrributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.foregroundColor:
        UIColor.snappCarTextGrey,
      NSAttributedString.Key.font:
        UIFont.boldSystemFont(ofSize: 15)]
    let priceAtrributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.foregroundColor:
        UIColor.snappCarSubTextGrey,
      NSAttributedString.Key.font:
        UIFont.systemFont(ofSize: 14)]
    
    if let currency = result?.priceInformation?.isoCurrencyCode,
      let price = result?.priceInformation?.price {
      let currencyPriceString = NSMutableAttributedString(
        string:currency,
        attributes:currencyAtrributes)
      let priceDecimal = String(format: "%.2f", price)
      currencyPriceString.append(NSMutableAttributedString(
        string:" \(priceDecimal) per day",
        attributes:priceAtrributes))
      priceLabel.attributedText = currencyPriceString
    }
    
    vehicleYearLabel.textColor = UIColor.snappCarSubTextGrey
    vehicleYearLabel.font = UIFont.systemFont(ofSize: 14)
    vehicleYearLabel.textAlignment = .left
    if let year = result?.car?.year {
      vehicleYearLabel.text = "\(year)"
    }
    
    freeKmLabel.textColor = UIColor.snappCarSubTextGrey
    freeKmLabel.font = UIFont.systemFont(ofSize: 14)
    freeKmLabel.textAlignment = .left
    if let freeKm = result?.priceInformation?.freeKilometersPerDay {
      freeKmLabel.text = "\(freeKm) km free"
    }
  }
}
