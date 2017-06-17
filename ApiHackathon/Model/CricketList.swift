//
//  CricketList.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit
import ObjectMapper

class DcirqUserCirclesApi: Mappable {
  
  var squad: Bool?
  var team1: String?
  var matchStarted: Bool?
  var team2 : String?
  var date: String?
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    squad <- map["squad"]
    team1 <- map["team-1"]
    matchStarted <- map["matchStarted"]
    team2 <- map["team-2"]
    date <- map["date"]

  }
  
}

