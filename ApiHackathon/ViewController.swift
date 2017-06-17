//
//  ViewController.swift
//  ApiHackathon
//
//  Created by sudharsan prem on 17/06/17.
//  Copyright © 2017 MegaMind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var gridViewCollectionview: UICollectionView!
  
  var colors = [UIColor]()
  
  var gridTitles = [String]()
  var color = UIColor()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    colors = [UIColor(red: 255/255.0, green: 133/255.0, blue: 0/255.0, alpha: 1.0),
    UIColor(red: 46/255.0, green: 204/255.0, blue: 133/255.0, alpha: 1.0),
    UIColor(red: 52/255.0, green: 150/255.0, blue: 219/255.0, alpha: 1.0),
    UIColor(red: 155/255.0, green: 89/255.0, blue: 182/255.0, alpha: 1.0)]
    
    
    let nib = UINib(nibName: "gridViewCell", bundle: nil)
    gridViewCollectionview.register(nib, forCellWithReuseIdentifier: "gridViewCell")
    gridViewCollectionview.contentInset = UIEdgeInsetsMake(5, 5, 5, 5)


    
    self.gridTitles = ["Fuel","Train","Cricket","News"]
    
    self.automaticallyAdjustsScrollViewInsets = false
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
   return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.gridTitles.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridViewCell", for: indexPath) as! gridViewCell
    let color = self.colors[indexPath.item]
    cell.gridViewContainer.backgroundColor = color
    let values = self.gridTitles[indexPath.row]

    cell.img.image = UIImage(named: values)
    cell.title.text = values
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.gridViewCollectionview.frame.size.width/2 - 10, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let passColor = self.colors[indexPath.item]

    if indexPath.item == 0
    {
      self.color = passColor
      self.performSegue(withIdentifier: "passFuelData", sender: nil)
    }else if indexPath.item == 1
    {
      self.color = passColor

      self.performSegue(withIdentifier: "passChennaiRouteData", sender: nil)
    }else if indexPath.item == 2
    {
      self.color = passColor

      self.performSegue(withIdentifier: "passCricketData", sender: nil)
    }else if indexPath.item == 3
    {
      self.color = passColor

      self.performSegue(withIdentifier: "passNewsSourceData", sender: nil)
    }
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "passFuelData"
    {
      let passFuel = segue.destination as! FuelPriceController
      passFuel.fuelColor = self.color
      
    }else if segue.identifier == "passChennaiRouteData"
    {
      let passChennai = segue.destination as! ChennaiTrainRouteController
      passChennai.chennaiTrainColor = self.color
      
    }else if segue.identifier == "passCricketData"
    {
      let passCricket = segue.destination as! CricketViewController
      passCricket.passCricketColor = self.color
      
    }else if segue.identifier == "passNewsSourceData"
    {
      let passNewsSource = segue.destination as! NewsSourceListViewController
      passNewsSource.newsSourceColor = self.color
      
    }
  }
  
}



