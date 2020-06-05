//
//  AppleIdButton.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/1/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import AuthenticationServices

// Wrapping ASAuthorizationAppleIdButton, so we could use it in SwiftUI
struct AppleIdButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
            ASAuthorizationAppleIDButton()
    }
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}

struct AppleIdButton_Previews: PreviewProvider {
    static var previews: some View {
        AppleIdButton()
    }
}
