//
//  NewsArticleViewController.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher
import SVProgressHUD

class NewsArticleViewController: UIViewController {

  @IBOutlet weak var newsArticleTableView: UITableView!
  
  var articleMapper = [AnyObject]()
  
  var passData = String()
    override func viewDidLoad() {
        super.viewDidLoad()

      let nib = UINib(nibName: "NewsArticleListCell", bundle: nil)
      newsArticleTableView.register(nib, forCellReuseIdentifier: "NewsArticleListCell")
    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    print("the passdata is \(passData)")
    self.callNewsArticleApi()
    
  }
  
  
  
  func callNewsArticleApi()
  {
    SVProgressHUD.show()
    
    
    let url = "http://52.36.211.72:5555/gateway/NewsAPI/1.0/articles"
    let header : HTTPHeaders = ["x-Gateway-APIKey":"1a33b919-5dcb-4556-8a29-701a3db3e885",
                                "Authorization":"Basic Og=="]
    
    let parameter : Parameters = ["source":self.passData]
    
    Alamofire.request(url, method: .get, parameters: parameter, headers: header).responseJSON { (response) in
      switch response.result
      {
        
      case .success(let values):
        let json = JSON(values)
        print("the values is \(json)")
        
        guard let sources = json["articles"].arrayObject else
        {
          return
        }
        
        sources.forEach({ (vls) in
          self.articleMapper.append(vls as AnyObject)
        })
        
        let _ = Mapper<CricketArticle>().map(JSONObject:  self.articleMapper)
        
        let feedArr : Array<CricketArticle> = Mapper<CricketArticle>().mapArray(JSONObject: self.articleMapper)!
        
        print("the feed count is \(feedArr.count)")
        
        self.newsArticleTableView.reloadData()
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
  

}

extension NewsArticleViewController:UITableViewDataSource,UITableViewDelegate
{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let feedArr : Array<CricketArticle> = Mapper<CricketArticle>().mapArray(JSONObject: self.articleMapper)!

    return feedArr.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsArticleListCell", for: indexPath) as! NewsArticleListCell
    
    let feedArr : Array<CricketArticle> = Mapper<CricketArticle>().mapArray(JSONObject: self.articleMapper)!

    cell.articleTitlr.text = feedArr[indexPath.row].title!
    cell.articleDescription.text = feedArr[indexPath.row].descriptions!
    let url = URL(string: feedArr[indexPath.row].urlToImage!)
    cell.articleImg.kf.setImage(with: url)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 350.0
  }
  
  
  
}
