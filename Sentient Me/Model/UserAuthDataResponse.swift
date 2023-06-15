//
//  UserAuthDataResponse.swift
//  Sentient Me
//
//  Created by Prince Saini on 09/06/23.
//

import Foundation

struct UserAuthDataResponse : Codable {
    var accessToken : String? = nil
     var tokenType   : String? = nil
     var expiration  : Int?    = nil
     var user        : User?   = User()

     enum CodingKeys: String, CodingKey {

       case accessToken = "accessToken"
       case tokenType   = "tokenType"
       case expiration  = "expiration"
       case user        = "user"
     
     }

     init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)

       accessToken = try values.decodeIfPresent(String.self , forKey: .accessToken )
       tokenType   = try values.decodeIfPresent(String.self , forKey: .tokenType   )
       expiration  = try values.decodeIfPresent(Int.self    , forKey: .expiration  )
       user        = try values.decodeIfPresent(User.self   , forKey: .user        )
    
     }

     init() {

     }
}

struct User: Codable {

  var id            : Int?    = nil
  var username      : String? = nil
  var valdiated     : Bool?   = nil
  var email         : String? = nil
  var currentPlan   : String? = nil
  var purchasedPlan : String? = nil
  var providerId    : String? = nil
  var provider      : String? = nil

  enum CodingKeys: String, CodingKey {

    case id            = "id"
    case username      = "username"
    case valdiated     = "valdiated"
    case email         = "email"
    case currentPlan   = "current_plan"
    case purchasedPlan = "purchased_plan"
    case providerId    = "provider_id"
    case provider      = "provider"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id            = try values.decodeIfPresent(Int.self    , forKey: .id            )
    username      = try values.decodeIfPresent(String.self , forKey: .username      )
    valdiated     = try values.decodeIfPresent(Bool.self   , forKey: .valdiated     )
    email         = try values.decodeIfPresent(String.self , forKey: .email         )
    currentPlan   = try values.decodeIfPresent(String.self , forKey: .currentPlan   )
    purchasedPlan = try values.decodeIfPresent(String.self , forKey: .purchasedPlan )
    providerId    = try values.decodeIfPresent(String.self , forKey: .providerId    )
    provider      = try values.decodeIfPresent(String.self , forKey: .provider      )
 
  }

  init() {

  }

}
