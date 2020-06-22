//
//  UserLoginManager.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/16/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//
import Foundation
import SwiftUI
import FacebookLogin



class UserLoginManager: ObservableObject {
    let loginManager = LoginManager()
    func facebookLogin(completionHandler:@escaping ()->Void) {
        
        loginManager.logIn(permissions: [.publicProfile, .email,.publicProfile], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
                
            case .cancelled:
                print("User cancelled login.")
                
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken) \n authToken:\(AccessToken.current?.tokenString)")
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        let fbDetails = result as! NSDictionary
                        print(fbDetails)
                        // Store fbAccessToken in User Defaults
                        UserDefaults.standard.set(AccessToken.current?.tokenString, forKey: "fbAccessToken")
                        completionHandler()
                    }
                    
                })
                
                

            }
        }
    }
    func facebookLogout(){
        loginManager.logOut()
    }
}


                             
