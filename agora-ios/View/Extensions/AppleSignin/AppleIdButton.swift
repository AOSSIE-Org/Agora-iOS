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
        ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    }
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}


final class SignInWithAppleCoordinator: NSObject {
    


    func getApppleRequest() {
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authController = ASAuthorizationController(authorizationRequests: [request])
        authController.delegate = self
        authController.performRequests()
    }
    
    private func setUserInfo(for userId: String, fullName: String?, email: String?) {
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: userId) { credentialState, error in
            var authState: String?
            
            switch credentialState {
                case .authorized: authState = "authorized"
                case .revoked: authState = "revoked"
                case .notFound: authState = "notFound"
                case .transferred: authState = "transferred"
                @unknown default:
                        fatalError()
                }
            

        }
    }
    
    
}

extension SignInWithAppleCoordinator: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let fullName = (credential.fullName?.givenName ?? "")
            print(credential.authorizationCode)
            setUserInfo(for: credential.user, fullName: fullName, email: credential.email)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign In with Apple ID Error: \(error.localizedDescription)")
    }
}


final class AppleViewModel: ObservableObject {
    var signInWithApple = SignInWithAppleCoordinator()
    
    @Published var user: DatabaseUser?
    
    func getRequest() {
        signInWithApple.getApppleRequest()
    }
}
