//
//  CricketSourceList.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit
import ObjectMapper

class CricketSource: Mappable {
  
  var id: String?
  var name : String?
  var descriptions: String?
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    descriptions <- map["description"]
  }
  

}


