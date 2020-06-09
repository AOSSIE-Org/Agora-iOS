//
//  AppUserDefaults.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/6/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation

public struct AppUserDefaults{
    @UserDefault("user_region", defaultValue: Locale.current.regionCode ?? "US")
    public static var region: String
    
}
