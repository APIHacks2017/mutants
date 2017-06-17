//
//  TrainRoute.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit
import ObjectMapper



class TrainRoute: Mappable {
  
  
  var source: String?
  var route : String?
  var descriptions: String?
  var time: String?
  var type: String?
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    source <- map["source"]
    route <- map["route"]
    descriptions <- map["description"]
    time <- map["time"]
    type <- map["type"]
  }
  
  
}

