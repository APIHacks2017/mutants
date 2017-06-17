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

class TrainListViewController: UIViewController {

  var json : JSON!
  
  @IBOutlet weak var trainlistTableView: UITableView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      print("tje json value is \(json)")
      let nib = UINib(nibName: "TrainListCell", bundle: nil)
      trainlistTableView.register(nib, forCellReuseIdentifier: "TrainListCell")
      
  
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
    return json.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TrainListCell", for: indexPath)
    
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
  
}
