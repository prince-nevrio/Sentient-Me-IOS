//
//  BaseViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 31/05/23.
//

import UIKit
import ToastViewSwift
import Firebase

class BaseViewController: UIViewController {
    var loadingIndicator : UIActivityIndicatorView?
    var userDefault : MyUserDefaults?
    let remoteConfig = RemoteConfig.remoteConfig()
    
    let config = ToastConfiguration(
        direction: .bottom,
        autoHide: true,
        enablePanToClose: true,
        displayTime: 3,
        animationTime: 0.2
    )
    
    
    override func viewDidLoad() {
        userDefault = MyUserDefaults()
        initLoadingView()
        self.configureUIonLoad()
    }
    
    func configureUIonLoad() {
        
    }
    
    func closeViewControler(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func openNewController(controller : UIViewController){
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(controller, animated: true)
        self.present(controller, animated: true, completion: nil)
    }
    
    func showToastMessage(message : String){
        let toast = Toast.text(message, config: config)
        toast.show()
    }
    
    private func initLoadingView(){
        loadingIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(loadingIndicator!)
        loadingIndicator?.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5)
    }
    
    // Call this method to show the loading indicator
    func showLoadingIndicator() {
        loadingIndicator?.startAnimating()
    }
    
    // Call this method to hide the loading indicator
    func hideLoadingIndicator() {
        self.loadingIndicator?.stopAnimating()
    }
    
    /* Display alert message */
    func showAlertMessage(message : String){
        let uialert = UIAlertController(title: "Invalid", message: message,
                                        preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(uialert, animated: true, completion: nil)
    }
    
    func initFirebaseConfigData(){
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetch(withExpirationDuration: 0,completionHandler: {status , error in
            if status == .success, error == nil{
                self.remoteConfig.activate(completion : {status , error in
                    guard error == nil else{
                        return
                    }
                    let appLeatestVersion = self.remoteConfig.configValue(forKey: Constants.FIREBASE_LEATEST_APP_VERSION).numberValue
                    let appMinimumVersion = self.remoteConfig.configValue(forKey: Constants.FIREBASE_MINIMUM_APP_VERSION).numberValue
                    print("App leatest version is \(String(describing: appLeatestVersion)) and minimum version is \(String(describing: appMinimumVersion))" )
                    if(isAppNewVersionAvailable(leatestVersion: appLeatestVersion.doubleValue)){
                        self.showUpdateAppAlertDialog(leatestVersion: appLeatestVersion,minimumVersion: appMinimumVersion)
                    }
                    
                })
            }
            else{
                print("Something went wrong with firebase config.")
            }
        })
    }
    
    func showUpdateAppAlertDialog(leatestVersion : NSNumber , minimumVersion : NSNumber){
        let refreshAlert = UIAlertController(title: "Update Available", message: "A new version of Sentient Me Application \(leatestVersion) is available now.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Update Now", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true)
            self.showToastMessage(message: "Work in progress.")
        }))
        if(!isAppNewVersionAvailable(leatestVersion: minimumVersion.doubleValue)){
            refreshAlert.addAction(UIAlertAction(title: "Skip", style: .cancel, handler: { (action: UIAlertAction!) in
                refreshAlert.dismiss(animated: true)
            }))
        }
        DispatchQueue.main.async {
            self.present(refreshAlert, animated: true, completion: nil)
        }
    }
    
}

extension UIViewController{
    func showToast(message : String){
        let toastLable = UILabel(frame: CGRect(x: (self.view.frame.size.width/2) - 135 , y: self.view.frame.size.height - 100, width: 250, height: 35))
        toastLable.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLable.textColor = UIColor.white
        toastLable.textAlignment = .center
        toastLable.text = message
        toastLable.alpha = 1
        toastLable.layer.cornerRadius = 10
        toastLable.clipsToBounds = true
        self.view.addSubview(toastLable)
        UIView.animate(withDuration: 4, delay:0.1 ,options: .curveEaseIn,animations: {
            toastLable.alpha = 0.0
        },completion : {(_) in
            toastLable.removeFromSuperview()
        })
    }
}
