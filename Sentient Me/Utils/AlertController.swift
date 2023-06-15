//
//  AlertController.swift
//  Sentient Me
//
//  Created by Prince Saini on 09/06/23.
//

import UIKit

typealias alertOkAction = ((_ controller: AlertController)->())

class AlertController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    var titleText: String!
    var subTitle: String! = ""
    var okButtonText: String!
    var okButtonAction: alertOkAction?
    
    class func controller(title: String, subTitle: String = "", okButtonText: String, okButtonAction: alertOkAction? = nil) -> AlertController {
        let controller = Storyboard.Util.instantiateViewController(withIdentifier: "AlertController") as! AlertController
        controller.titleText = title
        controller.subTitle = subTitle
        controller.okButtonText = okButtonText
        controller.okButtonAction = okButtonAction
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.okButton.setTitle(okButtonText, for: .normal)
        self.titleLabel.text = titleText
        self.subTitleLabel.text = subTitle
    }
    
    @IBAction func onOk() {
        if self.okButtonAction != nil {
            self.okButtonAction?(self)
        } else {
            self.dismiss(animated: true)
        }
    }
}
