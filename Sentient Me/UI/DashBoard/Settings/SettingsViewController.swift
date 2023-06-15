//
//  SettingsViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 13/06/23.
//

import UIKit

class SettingsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var dataList = ["Profile","Privacy Policy","Terms and Conditions","About Us","Invite Friends","Log out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(indexPath.row){
        case 5:
            logoutApp()
        default:
            print("")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SettingCollectionViewCell
        cell?.tvTitle.text = dataList[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
  func logoutApp(){
      let refreshAlert = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: UIAlertController.Style.alert)

      refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
          refreshAlert.dismiss(animated: true)
          MyUserDefaults.standard.logout()
          self.openNewController(controller: ViewController.controller())
      }))

      refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
          refreshAlert.dismiss(animated: true)
      }))

      present(refreshAlert, animated: true, completion: nil)
    }
    
}
