//
//  HomeViewController.swift
//  Sentient Me
//
//  Created by Prince Saini on 13/06/23.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var ivNotification: UIImageView!
    @IBOutlet weak var btnInviteFriends: UIView!
    @IBOutlet weak var btnTrackProgress: UIView!
    @IBOutlet weak var btnBadgeDetails: UIView!
    @IBOutlet weak var btnInstaFeeds: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButtonView()
        btnInviteFriends.setOnClickListener {
            self.shareLink(link: "https://sentientme.app.link/e/ABCDE12345")
        }
        btnTrackProgress.setOnClickListener {
            self.openNewController(controller: TrackMyProgressViewController.controller())
        }
        btnBadgeDetails.setOnClickListener {
            self.openNewController(controller: BadgeDetailsViewController.controller())
        }
        btnInstaFeeds.setOnClickListener {
            self.showToastMessage(message: "Work in progress")
        }
        
        ivNotification.setOnClickListener {
            self.openNewController(controller: NotificationsViewController.controller())
        }

    }
    
    override func configureUIonLoad() {
        initFirebaseConfigData()
    }
    
    func shareLink(link : String){
        if let name = URL(string: link), !name.absoluteString.isEmpty {
          let objectsToShare = [name]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        } else {
            self.showToastMessage(message: "Something went wrong.")
        }
    }
    
    func initButtonView(){
        btnInviteFriends.addBorder()
        btnTrackProgress.addBorder()
        btnBadgeDetails.addBorder()
        btnInstaFeeds.addBorder()
    }

}
