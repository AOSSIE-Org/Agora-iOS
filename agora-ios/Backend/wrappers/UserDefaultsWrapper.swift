//
//  UserDefaultsWrapper.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/6/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    let key:String
    let defaultValue: T
    
     init(_ key: String, defaultValue: T) {
         self.key = key
         self.defaultValue = defaultValue
     }
    
    public var wrappedValue:T{
         get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
               }
               set {
                   UserDefaults.standard.set(newValue, forKey: key)
               }
    }
    
    
}
