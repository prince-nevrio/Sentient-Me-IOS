//
//  ApiRepository.swift
//  Sentient Me
//
//  Created by Prince Saini on 09/06/23.
//

import Foundation
import UIKit

class ApiRepository{
    
    class func doLogin(deepLinkUrl: String, onCompletion: ((Result<UserAuthDataResponse?,Error>)->())? = nil) {
        MyNetwork.session.request(method: .post, urlPath: Endpoints.oculusLogin.path+deepLinkUrl, onCompletion: onCompletion)
    }
    
}
