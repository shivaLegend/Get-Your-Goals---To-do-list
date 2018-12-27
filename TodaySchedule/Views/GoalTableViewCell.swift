//
//  GoalTableViewCell.swift
//  TodaySchedule
//
//  Created by Nguyen Duc Tai on 12/20/18.
//  Copyright © 2018 Nguyen Duc Tai. All rights reserved.
//

import UIKit
import SwipeCellKit

class GoalTableViewCell: SwipeTableViewCell {

  @IBOutlet weak var titleLbl: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
