//
//  ActivityIndicator.swift
//  Cities
//
//  Created by Blake Loizdes on 7/27/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  internal var activityIndicatorTag: Int { return 999999 }
}

extension UIViewController {
  internal func startActivityIndicator(style: UIActivityIndicatorViewStyle = .whiteLarge, location: CGPoint? = nil) {
    let loc = location ?? self.view.center
    DispatchQueue.main.async {
      let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
      activityIndicator.tag = self.activityIndicatorTag
      activityIndicator.color = UIColor.snappCarBlue
      activityIndicator.center = loc
      activityIndicator.tintColor = UIColor.snappCarBlue
      activityIndicator.hidesWhenStopped = true
      activityIndicator.startAnimating()
      self.view.addSubview(activityIndicator)
    }
  }
  
  internal func stopActivityIndicator() {
    DispatchQueue.main.async {
      if let activityIndicator = self.view.subviews.filter({
        $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
      }
    }
  }
}
