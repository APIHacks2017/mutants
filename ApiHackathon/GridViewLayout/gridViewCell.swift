//
//  gridViewCell.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit

class gridViewCell: UICollectionViewCell {

  @IBOutlet weak var gridViewContainer: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()

      self.gridViewContainer.layer.cornerRadius = 5.0
      self.gridViewContainer.clipsToBounds = true
  }

}
