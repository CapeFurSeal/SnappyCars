//
//  BounceButton.swift
//  SnappCars
//
//  Created by Blake Loizides on 8/19/18.
//  Copyright © 2018 BCLab. All rights reserved.
//

import UIKit

class AppBounceButton: UIButton {
  
  fileprivate var minimumScale: CGFloat = 0.95
  fileprivate var pressSpringDamping: CGFloat = 0.4
  fileprivate var releaseSpringDamping: CGFloat = 0.35
  fileprivate var pressSpringDuration = 0.4
  fileprivate var releaseSpringDuration = 0.5
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    UIView.animate(withDuration: self.pressSpringDuration, delay: 0, usingSpringWithDamping: self.pressSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
      self.transform = CGAffineTransform(scaleX: self.minimumScale, y: self.minimumScale)
    }, completion: nil)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
      self.transform = CGAffineTransform.identity
    }, completion: nil)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    let location = touches.first!.location(in: self)
    if !self.bounds.contains(location) {
      UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
        self.transform = CGAffineTransform.identity
      }, completion: nil)
    }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
    super.touchesCancelled(touches!, with: event)
    UIView.animate(withDuration: self.releaseSpringDuration, delay: 0, usingSpringWithDamping: self.releaseSpringDamping, initialSpringVelocity: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
      self.transform = CGAffineTransform.identity
    }, completion: nil)
  }
}
