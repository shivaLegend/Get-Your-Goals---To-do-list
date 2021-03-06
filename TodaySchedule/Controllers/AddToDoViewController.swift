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
    
    //add color text view
    let borderColor = UIColor(displayP3Red: 58/255, green: 62/255, blue: 69/255, alpha: 1.0)
    textView.layer.borderColor = borderColor.cgColor
    textView.layer.borderWidth = 1.0
    textView.layer.cornerRadius = 5.0
    timeDatePicker.layer.borderColor = borderColor.cgColor
    timeDatePicker.layer.borderWidth = 1.0
    timeDatePicker.layer.cornerRadius = 5.0
    
    
    //add padding text view
    textView.textContainerInset = UIEdgeInsets(top: 8,left: 5,bottom: 8,right: 5) 
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
