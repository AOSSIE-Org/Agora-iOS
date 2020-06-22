//
//  FacebookButton.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/16/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit

// Wrapping ASAuthorizationAppleIdButton, so we could use it in SwiftUI
struct FacebookButton: UIViewRepresentable {
    
    func makeUIView(context: Context) -> FBButton {
        FBLoginButton()
        
    }
    
    func updateUIView(_ uiView:  FBButton, context: Context) {
        
    }
   
}

struct FacebookButton_Previews: PreviewProvider {
    static var previews: some View {
        FacebookButton()
    }
}
