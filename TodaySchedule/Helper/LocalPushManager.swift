//
//  LocalPushManager.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 12/30/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import Foundation
import UserNotifications

class LocalPushManager: NSObject {
  static var shared = LocalPushManager()
  let center = UNUserNotificationCenter.current()
  
  func requestAuthorization() {
    center.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
      if error == nil {
        print("granted permission")
      }
    }
  }
  
  //set local push
  func sendLocalPush() {
    //create local push content
    let content = UNMutableNotificationContent()
    content.title = NSString.localizedUserNotificationString(forKey: "Get your goals", arguments: nil)
    content.body = NSString.localizedUserNotificationString(forKey: "Complete schedule and get your goals!", arguments: nil)
    content.sound = UNNotificationSound.default
    
    //trigger push notification
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    
//    dateComponents.weekday = 3  // Tuesday
    dateComponents.hour = 7    // 14:00 hours
    
    // Create the trigger as a repeating event.
    let trigger = UNCalendarNotificationTrigger(
      dateMatching: dateComponents, repeats: true)
    let request = UNNotificationRequest(identifier: "Timer", content: content, trigger: trigger)
    center.add(request) { (error) in
      if error == nil {
        print("Schedule push success")
      }
    }
  }
}
