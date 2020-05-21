//
//  LoginView.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/18/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Image("RectangleR").resizable().edgesIgnoringSafeArea(.all).offset(x: 0, y: -320)
            Text("Don’t just be there,be present.").offset(x:-70,y:-280)
            Button(action: {
                
            }) {
                Text("GET STARTED").offset(x:0,y:-240)
            }
        }
        
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
