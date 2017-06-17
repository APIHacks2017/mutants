//
//  CricketViewController.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class CricketViewController: UIViewController {
  @IBOutlet weak var cricketTableList: UITableView!

  var cricketMapper = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
    let nib = UINib(nibName: "CricketCell", bundle: nil)
      cricketTableList.register(nib, forCellReuseIdentifier: "CricketCell")
      cricketTableList.translatesAutoresizingMaskIntoConstraints = true
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.callApi()
    
  }
  
  func callApi()
  {
    
    let url = "http://52.36.211.72:5555/gateway/Cricket%20API/1.0/matches"
    
    let header : HTTPHeaders = ["x-Gateway-APIKey":"be0b845e-b81a-488e-93e6-040ff7fd86c4"]
    let parameter : Parameters = ["apikey":"0CWPTXYxJmaPWm0eJMGwsrlqR9K2"]
    
    Alamofire.request(url, method: .get, parameters: parameter, headers: header).responseJSON { (response) in
      switch response.result
      {
      case .success(let values):
        let json = JSON(values)
        print("the values i \(json)")
        self.cricketMapper.removeAll()
        guard let matches = json["matches"].arrayObject else
        {
          return
        }
        
        
        matches.forEach({ (vls) in
          self.cricketMapper.append(vls as AnyObject)
        })
        
        
        let _ = Mapper<DcirqUserCirclesApi>().map(JSONObject: self.cricketMapper)
        
        let feedArr : Array<DcirqUserCirclesApi> = Mapper<DcirqUserCirclesApi>().mapArray(JSONObject:self.cricketMapper)!
        
        print("the feed list is \(feedArr.count)")
        self.cricketTableList.reloadData()
        
      case .failure(let error):
        print("the error is \(error)")
        
      }
    }
  
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}


extension CricketViewController:UITableViewDataSource,UITableViewDelegate
{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let feedArr : Array<DcirqUserCirclesApi> = Mapper<DcirqUserCirclesApi>().mapArray(JSONObject:self.cricketMapper)!

    return feedArr.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CricketCell", for: indexPath) as! CricketCell

    let feedArr : Array<DcirqUserCirclesApi> = Mapper<DcirqUserCirclesApi>().mapArray(JSONObject:self.cricketMapper)!

    let vls = feedArr[indexPath.item]
    
    cell.teamLabel.text = "\(vls.team1!) vs \(vls.team2!)"
    cell.dateLabel.text = "\(vls.date!)"
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 108.0
  }
  
}
