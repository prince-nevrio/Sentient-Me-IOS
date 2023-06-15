//
//  TrackMyProgressViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 14/06/23.
//

import UIKit

class TrackMyProgressViewController: BaseViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    var dataList = ["","","","","","","","","","","","","","","","",""]
    
    class func controller(parentController: UIViewController? = nil) -> TrackMyProgressViewController {
        let controller = Storyboard.TrackMyProgress.instantiateViewController(withIdentifier: "TrackMyProgressViewController") as! TrackMyProgressViewController
        controller.modalPresentationStyle = .fullScreen
        return controller
    }

    @IBAction func onbackClick(_ sender: Any) {
        self.closeViewControler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyProgressCollectionViewCell
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

}
