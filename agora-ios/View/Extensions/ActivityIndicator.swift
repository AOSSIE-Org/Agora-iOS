//
//  ActivityIndicator.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/8/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: View {
    
   @State var isAnimating: Bool = false
    
    var body: some View {
        
        GeometryReader { _ in
            VStack{
                
                Circle().trim(from: 0, to: 0.8).stroke(AngularGradient(gradient: .init(colors: [Color("Color2"), Color("Color1")]), center: .center),style: StrokeStyle(lineWidth: 9, lineCap: .round, lineJoin: .round))
                    .frame(width:45,height:45)
                    .rotationEffect(.init(degrees: self.isAnimating ? 360 : 0))
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
                }.padding()
                .background(Color.init(red: 0.89, green: 0.89, blue: 0.89))
            .cornerRadius(20)
            .shadow(radius: 10)
            .onAppear(){
                self.isAnimating.toggle()
            }
        }
       
        
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
