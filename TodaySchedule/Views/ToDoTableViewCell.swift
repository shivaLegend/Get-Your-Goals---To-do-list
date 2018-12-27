//
//  ToDoTableViewCell.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 11/25/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import SwipeCellKit

class ToDoTableViewCell: SwipeTableViewCell {

  @IBOutlet weak var uncheckImg: UIImageView!
  @IBOutlet weak var checkImg: UIImageView!
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var timeLbl: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
      if selected == true {
        if checkImg.isHidden == true {
          checkImg.isHidden = false
        } else {
          checkImg.isHidden = true
        }
      }
    }
    
}
