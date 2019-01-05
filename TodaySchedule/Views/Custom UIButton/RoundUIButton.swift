//
//  RoundUIButton.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 12/27/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
@IBDesignable
class RoundUIButton: UIButton {
  
  @IBInspectable var borderColor: UIColor = UIColor.white {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 2.0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable var shadowColor: UIColor = UIColor.white {
    didSet {
      self.layer.shadowColor = shadowColor.cgColor
    }
  }
  
  @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0) {
    didSet {
      self.layer.shadowOffset = shadowOffset
    }
  }
  
  @IBInspectable var shadowOpacity: Float = 1.0 {
    didSet {
      self.layer.shadowOpacity = shadowOpacity
    }
  }
  
  @IBInspectable var shadowRadius: CGFloat = 1.0 {
    didSet {
      self.layer.shadowRadius = shadowRadius
    }
  }
  
}

