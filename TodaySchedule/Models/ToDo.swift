//
//  ToDo.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 12/14/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import Foundation
import RealmSwift

class ToDo: Object {
    @objc dynamic var name = ""
  @objc dynamic var time = Date()
  @objc dynamic var check = false
}
