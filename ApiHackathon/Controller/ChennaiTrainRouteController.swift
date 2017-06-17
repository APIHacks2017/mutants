//
//  ChennaiTrainRouteController.swift
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

class ChennaiTrainRouteController: UIViewController {

  @IBOutlet weak var sourceDestination: HADropDown!
  
  @IBOutlet weak var destinaitonDropDown: HADropDown!
  
    var sourcePlace = [String]()
    var destinationPlace = [String]()
  var chennaiTrainColor = UIColor()
  var mapper = [AnyObject]()

  @IBOutlet weak var searchBtn: UIButton!
  
    var json : JSON!

    override func viewDidLoad() {
        super.viewDidLoad()

//      self.view.backgroundColor = self.chennaiTrainColor

      sourceDestination.delegate = self
      destinaitonDropDown.delegate = self

      
      self.searchBtn.layer.cornerRadius = 5.0
      self.searchBtn.clipsToBounds = true
      self.searchBtn.layer.borderWidth = 1.0
      self.searchBtn.layer.borderColor = UIColor.black.cgColor
      self.searchBtn.setTitleColor(UIColor.black, for: .normal)

      
    }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "passTrainList"
    {
      let destiny = segue.destination as! TrainListViewController
      destiny.mapper = mapper
      
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.callBusRouteApi()
  }
  
  
  @IBAction func searchBtn(_ sender: Any) {
   
    self.callBusApi(source: self.sourceDestination.title, destination: self.destinaitonDropDown.title)
    
  }
  
  
  func callBusApi(source:String,destination:String)
  {
    
    SVProgressHUD.show()
    let url = "http://52.36.211.72:5555/gateway/Chennai/v1/train/time"
    
    let parameter : Parameters = ["source":source,
                                 "destination":destination]
    
    let header : HTTPHeaders = ["x-Gateway-APIKey":"1a33b919-5dcb-4556-8a29-701a3db3e885",
                                "Authorization":"Basic Og=="]

    Alamofire.request(url, method: .get, parameters: parameter, headers: header).responseJSON { (response) in
      switch response.result
      {
      case .success(let values):
      let json = JSON(values)
        print("the values is \(json)")
      
      let arr = json.arrayObject
      
      self.mapper.removeAll()
      
      arr?.forEach({ (vls) in
        self.mapper.append(vls as AnyObject)
      })
      
   
      SVProgressHUD.dismiss()
        self.performSegue(withIdentifier: "passTrainList", sender: nil)
      case .failure(let error):
        print("the error is \(error)")
        SVProgressHUD.dismiss()

      
      }
    }
    
    
  }
  
  func callBusRouteApi()
  {
    
    SVProgressHUD.show()
    
    let url = "http://52.36.211.72:5555/gateway/Chennai/v1/train/routes"
    
    let header : HTTPHeaders = ["x-Gateway-APIKey":"1a33b919-5dcb-4556-8a29-701a3db3e885",
                                "Authorization":"Basic Og=="]

    Alamofire.request(url, method: .get, headers: header).responseJSON { (response) in
      switch response.result
      {
      case .success(let values):
        let json = JSON(values)
        self.getJsonValues(json: json)
        
        SVProgressHUD.dismiss()

      case .failure(let error):
        print("the error is \(error)")
        
        SVProgressHUD.dismiss()

      }
    }
    
    
  }
  
  func getJsonValues(json:JSON)
  {
    
    self.sourcePlace.removeAll()
    self.destinationPlace.removeAll()
    
    guard let arrVl = json.array else
    {
      return
    }
    
    arrVl.forEach { (vls) in
      
      guard let source = vls["source"].string else
      {
        return
      }
      
      guard let destination = vls["destination"].string else
      {
        return
      }
      
      if sourcePlace.contains(source)
      {
        
      }else
      {
      self.sourcePlace.append(source)
      }
      
      
      if destinationPlace.contains(destination)
      {
        
      }else
      {
      self.destinationPlace.append(destination)
      }

    }
    
    print("the source is \(self.sourcePlace)")
    self.sourceDestination.items = sourcePlace
    self.destinaitonDropDown.items = destinationPlace

  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChennaiTrainRouteController:HADropDownDelegate
{
  
  func didSelectItem(dropDown: HADropDown, at index: Int) {
    
  }
}
