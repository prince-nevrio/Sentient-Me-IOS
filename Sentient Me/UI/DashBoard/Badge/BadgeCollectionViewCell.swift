//
//  SettingCollectionViewCell.swift
//  Sentient Me
//
//  Created by Prince Saini on 14/06/23.
//

import UIKit

class BadgeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvPoints: UILabel!
    
    func loadData(point : Int){
        tvPoints.text = String(point)
        if(point>0){
            tvPoints.textColor = UIColor.systemGreen
        }
        else{
            tvPoints.textColor = UIColor.systemRed
        }
    }
    
}
