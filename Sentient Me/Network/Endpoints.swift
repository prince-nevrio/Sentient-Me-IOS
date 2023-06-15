//
//  Endpoints.swift
//  Sentient Me
//
//  Created by Prince Saini on 09/06/23.
//

import Foundation

enum Endpoints {
    case oculusLogin
    
    var path : String {
        switch self{
        case .oculusLogin:
            return "/api/user/login/Oculus/"

        }
    }
}

