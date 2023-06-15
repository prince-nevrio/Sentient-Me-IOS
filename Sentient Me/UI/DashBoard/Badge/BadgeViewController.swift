//
//  BadgeViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 13/06/23.
//

import UIKit

class BadgeViewController: BaseViewController , UICollectionViewDelegate,UICollectionViewDataSource{

    var dataList = [-5,5,-6,9,-3,6,-7,8,-8,9,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BadgeCollectionViewCell
        cell?.loadData(point: dataList[indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

    
}
