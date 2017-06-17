//
//  NewsArticleListCell.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit

class NewsArticleListCell: UITableViewCell {

  @IBOutlet weak var articleImg: UIImageView!
  
  @IBOutlet weak var articleTitlr: UILabel!
  
  @IBOutlet weak var articleDescription: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()

    self.articleImg.contentMode = .scaleAspectFill
      self.articleImg.clipsToBounds = true
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
