//
//  NotificationsViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 20/06/23.
//

import UIKit

class NotificationsViewController: BaseViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    var dataList = ["","","","","","","","","","","","","","","","",""]
    
    
    class func controller(parentController: UIViewController? = nil) -> NotificationsViewController {
        let controller = Storyboard.Notification.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
        controller.modalPresentationStyle = .fullScreen
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onbackClick(_ sender: Any) {
        self.closeViewControler()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NotificationCollectionViewCell
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }

}
