//
//  BadgeDetailsViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 14/06/23.
//

import UIKit

class BadgeDetailsViewController: BaseViewController {
    
    class func controller(parentController: UIViewController? = nil) -> BadgeDetailsViewController {
        let controller = Storyboard.BadgeDetails.instantiateViewController(withIdentifier: "BadgeDetailsViewController") as! BadgeDetailsViewController
        controller.modalPresentationStyle = .fullScreen
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onBackClick(_ sender: Any) {
        self.closeViewControler()
    }
}
