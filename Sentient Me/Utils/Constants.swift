//
//  Constants.swift
//  Sentient Me
//
//  Created by Prince Saini on 31/05/23.
//

import UIKit

class Constants: NSObject {

    static var BASE_URL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    
    static var DEEP_LINK_URL_STARTED = "sentient://oa/"
    static var REDIRECT_URL = "https://sentient.nevrio.tech/oculus/login"
    static var OCULUS_AUTH_URL = "https://auth.oculus.com/sso/?organization_id=203779285328467&redirect_uri="
    
    static var FIREBASE_LEATEST_APP_VERSION = "leatestVersionIOS"
    static var FIREBASE_MINIMUM_APP_VERSION = "minimumVersionIOS"
    
   
}
