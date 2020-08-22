//
//  ButtonModifier.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/19/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//
import SwiftUI

struct ButtonModifier: ViewModifier {
    var width:CGFloat = 360
    var height:CGFloat = 50
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .background(LinearGradient(gradient: Gradient(colors: [Color("Color2_2"), Color("Color2")]), startPoint: .bottom, endPoint: .top))
            .cornerRadius(20)
            .frame(width:width,height: height)
    }
}

extension View {
    func customButton(width:CGFloat) -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier(width: width))
    }
}

extension Text {
    func customTitleText() -> Text {
        self
            .fontWeight(.black)
            .font(.system(size: 36, design: .rounded))
    }
}

extension Color {
    static var mainColor = Color(UIColor.systemRed)
}


