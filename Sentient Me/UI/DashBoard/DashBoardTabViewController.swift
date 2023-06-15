//
//  DashBoardTabViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 31/05/23.
//

import UIKit

class DashBoardTabViewController: UITabBarController {
    
    

    class func controller(url : String? = nil,parentController: UIViewController? = nil) -> DashBoardTabViewController {
        let controller = Storyboard.DashBoard.instantiateViewController(withIdentifier: "DashBoardTabViewController") as! DashBoardTabViewController
        controller.modalPresentationStyle = .fullScreen
        return controller
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
