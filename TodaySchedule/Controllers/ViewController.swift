//
//  ViewController.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 11/25/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit



class ViewController: UIViewController {
  
  @IBOutlet weak var toDoTableView: UITableView!
  @IBOutlet weak var goalsTableView: UITableView!
  
  @IBOutlet weak var monthDayLbl: UILabel!
  @IBOutlet weak var addGoalButton: UIButton!
  @IBOutlet weak var dayLbl: UILabel!
  var realm = try! Realm()
//  var toDoList: Results<ToDo>?
  var goalList: Results<Goal>?
  
  var toDoList: Results<ToDo> {
    get {
      return realm.objects(ToDo.self).sorted(byKeyPath: "time", ascending: true) //Sort array
    }
  }
  //Start data everyday
//  let beginingday = NSCalendar.current.dateComponents([.hour, .minute], from: Date())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //get current date
    let date = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: date)
    guard let day = date.dayOfWeek() else {return}
    guard let dayNumber = components.day else {return}
    dayLbl.text = day
    monthDayLbl.text = date.month + " " + String(dayNumber)
    
    // -------------------
    
//    toDoList = realm.objects(ToDo.self)
    goalList = realm.objects(Goal.self)
    
    //add observing to reload data
    NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadToDoList"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(loadGoal), name: NSNotification.Name(rawValue: "loadGoal"), object: nil)
    
    //register xib file cell
    toDoTableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
    goalsTableView.register(UINib(nibName: "GoalTableViewCell", bundle: nil), forCellReuseIdentifier: "GoalTableViewCell")
    // ----------------------
    
//    print(beginingday.description)
  }
  
  @objc func loadList() {
    let range = NSMakeRange(0, self.toDoTableView.numberOfSections)
    let sections = NSIndexSet(indexesIn: range)
    self.toDoTableView.reloadSections(sections as IndexSet, with: .automatic)
//    toDoTableView.reloadData()
  }
  
  @objc func loadGoal() {
    let range = NSMakeRange(0, self.goalsTableView.numberOfSections)
    let sections = NSIndexSet(indexesIn: range)
    self.goalsTableView.reloadSections(sections as IndexSet, with: .automatic)
//    goalsTableView.reloadData()
  }
  
  func updateClock(date: Date) -> String{
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: date)

    //if statement if components hour > 12 then subtract 12 if not then leave it alone.
    var hour = components.hour! > 12 ? components.hour! - 12 : components.hour
    
    //this is an if statement if hour is = to 0 then 12 else it is equal to hour.
    hour = hour == 0 ? 12 : hour
    guard let finalHour = hour else {return "0"}
    guard let finalMinutes = components.minute else {return "0"}
    let hourString = finalHour > 9 ? "\(String(describing: finalHour))" : "0\(String(describing: finalHour))"
    let minutes = finalMinutes > 9 ? "\(String(describing: finalMinutes))" : "0\(String(describing: finalMinutes))"
    
    //this is an if statement if am is > then am is pm if < than it is am.
    let am = components.hour! > 12 ? "PM" : "AM"
    
    return "\(hourString):\(minutes) \(am)"
    
  }
  
  @IBAction func addScheduleClickButton(_ sender: Any) {
  }
  
  @IBAction func addGoalsClickButton(_ sender: Any) {
  }
  
  @IBAction func doneButton_Press(_ sender: UIButton) {
    let alert = UIAlertController(title: "Delete Every Thing", message: nil, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      self.dismiss(animated: true, completion: nil)
    }
    let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
      // Delete all objects from the realm
      try! self.realm.write {
        self.realm.deleteAll()
      }
      self.loadList()
      self.loadGoal()
    }
    alert.addAction(cancelAction)
    alert.addAction(yesAction)
    present(alert, animated: true)
  }
  
}

// MARK: - UITableView Delegate & Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == goalsTableView {
      if (goalList?.count)! < 3 {
        addGoalButton.isHidden = false
      } else {
        addGoalButton.isHidden = true
      }
      return goalList?.count ?? 0
    }
    return toDoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView == goalsTableView {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell", for: indexPath) as! GoalTableViewCell
      cell.delegate = self
      cell.titleLbl.text = goalList![indexPath.row].name
      return cell
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
    cell.delegate = self
    cell.nameLbl.text = toDoList[indexPath.row].name
    
    //take the time
    let date = toDoList[indexPath.row].time
//    let calendar = Calendar.current
//    let comp = calendar.dateComponents([.hour, .minute], from: date)
//
//    let hourInt = comp.hour
//    let minuteInt = comp.minute
//    var hourString : String!
//    var minuteString: String!
//    if hourInt! < 10 {
//      hourString = String(describing: comp.hour!)
//      hourString = "0" + hourString
//    } else {
//      hourString = String(describing: comp.hour!)
//    }
//
//    if minuteInt! < 10 {
//      minuteString = String(describing: comp.minute!)
//      minuteString = "0" + minuteString
//    } else {
//      minuteString = String(describing: comp.minute!)
//    }
//
//    if hourInt! <= 12 {
//      minuteString = minuteString + " AM"
//    } else {
//      minuteString = minuteString + " PM"
//    }
    
//    cell.timeLbl.text = hourString + ":" + minuteString
    cell.timeLbl.text = updateClock(date: date)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

extension ViewController: SwipeTableViewCellDelegate {
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    
    guard orientation == .right else { return nil }
    
    let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
      // handle action by updating model with deletion
      if tableView == self.toDoTableView {
        self.updateModel(at: indexPath)
      } else {
        self.updateGoals(at: indexPath)
      }
      
    }
    
    // customize the action appearance
    deleteAction.image = UIImage(named: "delete-icon")
    
    return [deleteAction]
  }
  
  func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
    var options = SwipeTableOptions()
    options.expansionStyle = .destructive
    return options
  }
  
  func updateModel(at indexPath: IndexPath) {
    // Update our data model.
    
    let item = toDoList[indexPath.row]
      do {
        try realm.write {
          realm.delete(item)
        }
      } catch {
        print("Error deleting Item, \(error)")
      }
    
  }
  
  func updateGoals(at indexPath: IndexPath) {
    // Update our data model.

    if let item = goalList?[indexPath.row] {
      do {
        try realm.write {
          realm.delete(item)
        }
      } catch {
        print("Error deleting Item, \(error)")
      }
    }
  }
  
}


