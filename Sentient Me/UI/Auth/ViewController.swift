//
//  ViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 31/05/23.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var continoueWithMetaButton: UIButton!
    var deepLinkUrl : String? = nil
    
    class func controller(url : String? = nil,parentController: UIViewController? = nil) -> ViewController {
        let controller = Storyboard.Login.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        controller.modalPresentationStyle = .fullScreen
        controller.deepLinkUrl = url
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.deepLinkUrl == nil){
            initLoginButton()
        }
        else{
            callLoginApi()
        }
    }
    
    func initLoginButton(){
        continoueWithMetaButton.layer.borderColor = UIColor.black.cgColor
        continoueWithMetaButton.layer.borderWidth = 1.0
        continoueWithMetaButton.layer.cornerRadius = 5.0
        continoueWithMetaButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        continoueWithMetaButton.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        continoueWithMetaButton.layer.shadowOpacity = 2.0
        continoueWithMetaButton.layer.shadowRadius = 0.0
        continoueWithMetaButton.layer.masksToBounds = false
    }
    
    
    @IBAction func onContinoueWithMetaClick(_ sender: Any) {
        if let url = URL(string: Constants.OCULUS_AUTH_URL+Constants.REDIRECT_URL), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        // openOnBoardingScreen()
    }
    
    /* Open onboarding screen to create account*/
    func openOnBoardingScreen(){
        let vc = OnBoardingViewController.controller()
        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    func callLoginApi(){
        self.showLoadingIndicator()
        ApiRepository.doLogin(deepLinkUrl: self.deepLinkUrl!){ result in
            self.hideLoadingIndicator()
            switch result {
            case .success(let authResponse):
                MyUserDefaults.standard.authenticationData = authResponse
                self.openOnBoardingScreen()
                break
            case .failure(let error):
                if let networkError = error as? NetworkError, networkError == .internetNotReachable {
                    MyNetwork.showNetworkError(controller: self, error: error)
                } else {
                    self.showToastMessage(message: "Something went wrong.")
                }
                print(error)
                break
            }
        }
    }
    
}

