//
//  FuelPriceController.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import SwiftyJSON

class FuelPriceController: UIViewController {

  
  @IBOutlet weak var dropdown: HADropDown!
  
  @IBOutlet weak var typesDropdown: HADropDown!
  
  
  @IBOutlet weak var priceLabel: UILabel!
  
  
  
  
  var selectedCountry : String?
  var selectedType : String?
  
  var citiesArray = [String]()
  var typesArray = [String]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      typesDropdown.delegate = self
      dropdown.delegate = self
      typesArray = ["petrol","diesel"]
      typesDropdown.items = typesArray
      
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.callFuelContryApi()

    
  }
  
  func callFuelContryApi()
  {
    
    firstly{
      self.callFuelApi()
      }.then{ response in
        self.getFuelResponse(json: response)
      }.catch { (error) in
        print("error is \(error)")
      }.always {
        
    }
    
  }
  
  func callFuelApi() -> Promise<JSON>
  {
    return Promise{ fullfill,reject in

      let url = "http://52.36.211.72:5555/gateway/FuelPriceIndia/1.0/main/city_list"
      
      let header : HTTPHeaders = ["x-Gateway-APIKey":"1a33b919-5dcb-4556-8a29-701a3db3e885",
                                  "Authorization":"Basic Og=="]
      Alamofire.request(url, method: .get, headers: header)
      .responseJSON(completionHandler: { (response) in
        switch response.result
        {
        case .success(let values):
          let json = JSON(values)
          fullfill(json)
        case .failure(let error):
          reject(error)
        }
      })
    }
    
  }
  
  func getFuelResponse(json:JSON)
  {
    
    self.citiesArray.removeAll()
    guard let cities = json["cities"].arrayObject else
    {
      return
    }
    
    cities.forEach { (reps) in
      
      self.citiesArray.append(String(describing: reps))
    }
    print("the response is \(cities)")

    dropdown.items = self.citiesArray
  }
  
  
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  
  @IBAction func searchBtn(_ sender: Any) {
    
    
    print("the price list is \(self.dropdown.title) and \(self.typesDropdown.title)")
    self.callpriceApi(country: self.dropdown.title, type: self.typesDropdown.title)
    
  }
  
  
  func callpriceApi(country:String,type:String)
  {
    
    let url = "http://52.36.211.72:5555/gateway/FuelPriceIndia/1.0/main/\(country)/\(type)/price"
    
    print("url is \(url)")
    let header : HTTPHeaders = ["x-Gateway-APIKey":"1a33b919-5dcb-4556-8a29-701a3db3e885",
                                "Authorization":"Basic Og=="]

    Alamofire.request(url, method: .get, headers: header).responseJSON { (response) in
      switch response.result
      {
      case .success(let values):
        let json = JSON(values)
         let vl = json["price"]
        let price = String(describing: vl)
      
        self.priceLabel.text = "the price value is \(price)"
      case .failure(let error):
        print("the error is \(error)")
      }
    }
  }

  
  
}

extension FuelPriceController:HADropDownDelegate {
  
  func didSelectItem(dropDown: HADropDown, at index: Int) {
    
    
    print("the item is \(self.dropdown.title)")
    
    print("the type is \(self.typesDropdown.title)")
  
    }
  

}
