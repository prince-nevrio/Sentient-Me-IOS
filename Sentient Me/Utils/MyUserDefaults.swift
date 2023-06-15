//
//  MyUserDefaults.swift
//  Sentient Me
//
//  Created by Prince Saini on 31/05/23.
//

import Foundation

class MyUserDefaults {
    
    static let standard = MyUserDefaults()
    private let userDefaults = UserDefaults.standard
    var USER_TOKEN = "user_token"
    
    var authenticationData: UserAuthDataResponse? {
        get {
            if let data = self.userDefaults.data(forKey: "AuthenticationData") {
                if let object = try? JSONDecoder().decode(UserAuthDataResponse.self, from: data) {
                    return object
                }
            }
            return nil
        }
        set {
            if newValue == nil {
                self.userDefaults.removeObject(forKey: "AuthenticationData")
            } else {
                if let encoded = try? JSONEncoder().encode(newValue) {
                    self.userDefaults.set(encoded, forKey: "AuthenticationData")
                }
            }
        }
    }
    
    var deviceId: String {
        get {
            if let deviceId = self.userDefaults.string(forKey: "DeviceId") {
                return deviceId
            } else {
                let id = UUID().uuidString
                self.userDefaults.setValue(id, forKey: "DeviceId")
                return id
            }
        }
        set {
            self.userDefaults.set(newValue, forKey: "DeviceId")
        }
    }
    
    func logout(){
        authenticationData = nil
    }
    
}
