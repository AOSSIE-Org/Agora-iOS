//
//  Settings.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/22/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        VStack {
            Button(action: {
                           
                         
                           
                           UserDefaults.standard.set(false, forKey: "status")
                           
                           NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                           
                           
                       }) {
                           Text("Logout")
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
