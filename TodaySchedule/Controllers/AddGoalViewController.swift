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
      
      let borderColor = UIColor(displayP3Red: 58/255, green: 62/255, blue: 69/255, alpha: 1.0)
      goalTextView.layer.borderColor = borderColor.cgColor
      goalTextView.layer.borderWidth = 1.0
      goalTextView.layer.cornerRadius = 5.0
      
      //add padding text view
      goalTextView.textContainerInset = UIEdgeInsets(top: 8,left: 5,bottom: 8,right: 5)
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
