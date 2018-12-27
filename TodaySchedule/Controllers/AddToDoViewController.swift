//
//  AddToDoViewController.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 11/26/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import RealmSwift

class AddToDoViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var timeDatePicker: UIDatePicker!
  @IBOutlet weak var toDoTextView: UITextView!
  
  
  var realm = try! Realm()
  
  override func viewDidLoad() {
        super.viewDidLoad()
      toDoTextView.text = "You can do it !"
    toDoTextView.textColor = UIColor.lightGray
    toDoTextView.delegate = self
    
    }
    
  @IBAction func cancelClick(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveClick(_ sender: Any) {

    let toDo = ToDo()
    toDo.name = textView.text
    toDo.time = timeDatePicker.date
    try! realm.write {
      realm.add(toDo)
    }
    
    dismiss(animated: true, completion: {
      
    })
    
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadToDoList"), object: nil)
    
  }
  
  
}

extension AddToDoViewController: UITextViewDelegate {
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
