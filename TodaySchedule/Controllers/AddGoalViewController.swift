//
//  AddGoalViewController.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 12/20/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import RealmSwift

class AddGoalViewController: UIViewController {
  @IBOutlet weak var goalTextView: UITextView!
  
  var realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

      goalTextView.text = "Set your goal !"
      goalTextView.textColor = UIColor.lightGray
      goalTextView.delegate = self
    }
    
  @IBAction func cancelClick(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func saveClick(_ sender: Any) {
    
    let goal = Goal()
    goal.name = goalTextView.text
    try! realm.write {
      realm.add(goal)
    }
    dismiss(animated: true, completion: {
      
    })

    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadGoal"), object: nil)
    
  }

}

extension AddGoalViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "You can do it !"
      textView.textColor = UIColor.lightGray
    }
  }
}
