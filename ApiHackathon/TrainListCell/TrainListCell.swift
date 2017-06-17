//
//  TrainListCell.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit

class TrainListCell: UITableViewCell {
  @IBOutlet weak var timeLabel: UILabel!

  @IBOutlet weak var routeLabe: UILabel!
  
  @IBOutlet weak var typeLabel: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
