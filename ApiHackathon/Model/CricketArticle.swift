//
//  CricketArticle.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit
import ObjectMapper

class CricketArticle: Mappable {
  
  
  var title: String?
  var url : String?
  var descriptions: String?
  var urlToImage: String?
  var publishedAt: String?
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    title <- map["title"]
    url <- map["url"]
    descriptions <- map["description"]
    urlToImage <- map["urlToImage"]
    publishedAt <- map["publishedAt"]
  }
  

}


