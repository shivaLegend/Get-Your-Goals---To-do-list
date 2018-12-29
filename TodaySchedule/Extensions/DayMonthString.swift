//
//  DayOfWeek.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 12/28/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit

extension Date {
  func dayOfWeek() -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: self).capitalized
    // or use capitalized(with: locale) if you want
  }
  
  var month: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    return dateFormatter.string(from: self)
  }
}


