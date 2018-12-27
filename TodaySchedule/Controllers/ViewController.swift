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
  
  var realm = try! Realm()
//  var toDoList: Results<ToDo>?
  var goalList: Results<Goal>?
  var toDoList: Results<ToDo> {
    get {
      return realm.objects(ToDo.self).sorted(byKeyPath: "time", ascending: true)
    }
  }

//  let beginingday = NSCalendar.current.dateComponents([.hour, .minute], from: Date())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    toDoList = realm.objects(ToDo.self)
    goalList = realm.objects(Goal.self)
    
    for i in toDoList {
      print(i)
    }
    
    //add observing to reload data
    NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "loadToDoList"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(loadGoal), name: NSNotification.Name(rawValue: "loadGoal"), object: nil)
    
    toDoTableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
    goalsTableView.register(UINib(nibName: "GoalTableViewCell", bundle: nil), forCellReuseIdentifier: "GoalTableViewCell")
    
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
  
  @IBAction func addScheduleClickButton(_ sender: Any) {
  }
  
  @IBAction func addGoalsClickButton(_ sender: Any) {
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == goalsTableView {
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
    
    let date = toDoList[indexPath.row].time
    let calendar = Calendar.current
    let comp = calendar.dateComponents([.hour, .minute], from: date)
    
    let hourInt = comp.hour
    let minuteInt = comp.minute
    var hourString : String!
    var minuteString: String!
    if hourInt! < 10 {
      hourString = String(describing: comp.hour!)
      hourString = "0" + hourString
    } else {
      hourString = String(describing: comp.hour!)
    }
    
    if minuteInt! < 10 {
      minuteString = String(describing: comp.minute!)
      minuteString = "0" + minuteString
    } else {
      minuteString = String(describing: comp.minute!)
    }
    
    
    
    cell.timeLbl.text = hourString + ":" + minuteString
    
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


