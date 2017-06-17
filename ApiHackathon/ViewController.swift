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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    colors = [UIColor.red,UIColor.blue,UIColor.black,UIColor.yellow,UIColor.purple]
    

    let nib = UINib(nibName: "gridViewCell", bundle: nil)
    gridViewCollectionview.register(nib, forCellWithReuseIdentifier: "gridViewCell")
    gridViewCollectionview.contentInset = UIEdgeInsetsMake(5, 5, 5, 5)

//    let nib1 = UINib(nibName: "gridViewHeaderCell", bundle: nil)
//    gridViewCollectionview.register(nib1, forSupplementaryViewOfKind: , withReuseIdentifier: <#T##String#>)
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
    return self.colors.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridViewCell", for: indexPath) as! gridViewCell
    let color = self.colors[indexPath.item]
    cell.gridViewContainer.backgroundColor = color
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.gridViewCollectionview.frame.size.width/2 - 10, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if indexPath.item == 0
    {
      self.performSegue(withIdentifier: "passFuelData", sender: nil)
    }else if indexPath.item == 1
    {
      self.performSegue(withIdentifier: "passChennaiRouteData", sender: nil)
    }
  }
  
}



