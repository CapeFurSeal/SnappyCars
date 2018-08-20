//
//  AlertController.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/15/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  internal func presentAlertController(withTitle title: String,
                                       message : String) {
    let alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK",
                                 style: .default)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true,
                 completion: nil)
  }
  
  internal func showActionsheet(viewController: UIViewController, title: String, message: String, actions: [(String, UIAlertActionStyle)], completion: @escaping (_ index: Int, _ sortType:String) -> Void) {
    let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    for (index, (title, style)) in actions.enumerated() {
      let alertAction = UIAlertAction(title: title, style: style) { (_) in
        completion(index,title)
      }
      alertViewController.addAction(alertAction)
    }
    viewController.present(alertViewController, animated: true, completion: nil)
  }
}
