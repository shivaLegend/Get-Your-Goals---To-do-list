//
//  RoundUIView.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 12/27/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
@IBDesignable
class RoundUIView: UIView {
  
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
  
}
