//
//  NewsSourceListViewController.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import SVProgressHUD

class NewsSourceListViewController: UIViewController {

  @IBOutlet weak var newsSourceTableView: UITableView!
  
  var passIdData = String()
  var newsSourceMapper = [AnyObject]()
  
  var newsSourceColor = UIColor()
    override func viewDidLoad() {
        super.viewDidLoad()

      let nib = UINib(nibName: "NewsSourceListCell", bundle: nil)
      newsSourceTableView.register(nib, forCellReuseIdentifier: "NewsSourceListCell")
      newsSourceTableView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.callNewsSourceApi()
  }

  func callNewsSourceApi()
  {
    
    SVProgressHUD.show()
    
    let url = "http://52.36.211.72:5555/gateway/NewsAPI/1.0/sources"
    let header : HTTPHeaders = ["x-Gateway-APIKey":"1a33b919-5dcb-4556-8a29-701a3db3e885",
                                "Authorization":"Basic Og=="]

    Alamofire.request(url, method: .get, headers: header).responseJSON { (response) in
      switch response.result
      {

      case .success(let values):
        let json = JSON(values)
        print("the values is \(json)")
        
        guard let sources = json["sources"].arrayObject else
        {
          return
        }
        
        sources.forEach({ (vls) in
          self.newsSourceMapper.append(vls as AnyObject)
        })
        
        let _ = Mapper<CricketSource>().map(JSONObject:  self.newsSourceMapper)
        
        let feedArr : Array<CricketSource> = Mapper<CricketSource>().mapArray(JSONObject: self.newsSourceMapper)!
        
        print("the feed count is \(feedArr.count)")
        
        self.newsSourceTableView.reloadData()
          SVProgressHUD.dismiss()
      
      case .failure(let error):
        print("the error is \(error)")
        SVProgressHUD.dismiss()
        
      }
    }
    
  }
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "passDataInArticle"
    {
      let destiny = segue.destination as! NewsArticleViewController
      
      destiny.passData = self.passIdData
      
    }
  }
    

}

extension NewsSourceListViewController:UITableViewDataSource,UITableViewDelegate
{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let feedArr : Array<CricketSource> = Mapper<CricketSource>().mapArray(JSONObject: self.newsSourceMapper)!

    return feedArr.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceListCell", for: indexPath) as! NewsSourceListCell
    
    let feedArr : Array<CricketSource> = Mapper<CricketSource>().mapArray(JSONObject: self.newsSourceMapper)!

    cell.tileLabel.text = feedArr[indexPath.row].name!
    cell.descriptionLabel.text = feedArr[indexPath.row].descriptions!
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let feedArr : Array<CricketSource> = Mapper<CricketSource>().mapArray(JSONObject: self.newsSourceMapper)!

    print("the indexpath is \(feedArr[indexPath.row].id!)")
    
    self.passIdData = feedArr[indexPath.row].id!
    self.performSegue(withIdentifier: "passDataInArticle", sender: nil)
    
  }
}


