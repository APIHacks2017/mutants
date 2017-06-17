//
//  TrainListViewController.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import ObjectMapper

class TrainListViewController: UIViewController {

  var json : JSON!
  
  @IBOutlet weak var trainlistTableView: UITableView!
  
  
  var mapper = [AnyObject]()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      print("tje json value is \(json)")
      let nib = UINib(nibName: "TrainListCell", bundle: nil)
      trainlistTableView.register(nib, forCellReuseIdentifier: "TrainListCell")
      trainlistTableView.translatesAutoresizingMaskIntoConstraints = true
  
  }
  


  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
   
    let _ = Mapper<TrainRoute>().map(JSONObject: self.mapper)
    
    let feedArr : Array<TrainRoute> = Mapper<TrainRoute>().mapArray(JSONObject:self.mapper)!
  
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

  }
    

  
}

extension TrainListViewController:UITableViewDataSource,UITableViewDelegate
{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    let feedArr : Array<TrainRoute> = Mapper<TrainRoute>().mapArray(JSONObject:self.mapper)!
    return feedArr.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TrainListCell", for: indexPath) as! TrainListCell
    
    let feedArr : Array<TrainRoute> = Mapper<TrainRoute>().mapArray(JSONObject:self.mapper)!
    
    
    cell.timeLabel.text = feedArr[indexPath.row].time!
    cell.routeLabe.text = feedArr[indexPath.row].route!
    cell.typeLabel.text = feedArr[indexPath.row].type!

    
    
    
    
    

    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
  
}
