//
//  TopCircleShape.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/1/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI

struct TopCircleShape: View {

     let topGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [Color("Color1"), Color("Color2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
      var body: some View {
        Rectangle()
        .fill(topGradient)
        .clipShape(CornersShape(corner: [.bottomLeft,.bottomRight], size: CGSize(width: 124, height: 124)))
        .padding(.bottom,10)
      }
}

struct TopCircleShape_Previews: PreviewProvider {
    static var previews: some View {
        TopCircleShape()
    }
}
