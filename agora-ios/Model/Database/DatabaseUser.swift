//
//  DatabaseUser.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/11/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation
import RealmSwift


class DatabaseUser: Object{
    @objc dynamic var username:String = ""
    @objc dynamic var email:String = ""
    @objc dynamic var firstName:String = ""
    @objc dynamic var lastName:String = ""
    @objc dynamic var avatarURL:String = ""
    @objc dynamic var twoFactorAuthentication:Bool = false
    @objc dynamic var token:String = ""
    @objc dynamic var expiresOn:Date = Date()
    @objc dynamic var trustedDevice:String = ""
    
    override static func primaryKey() -> String? {
        return "username"
    }
    
    
}
