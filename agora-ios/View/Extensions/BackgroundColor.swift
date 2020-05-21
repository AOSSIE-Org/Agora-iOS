//
//  BackgroundColor.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/25/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI


extension View {
  func background(with color: Color) -> some View {
    background(GeometryReader { geometry in
      Rectangle().path(in: geometry.frame(in: .local)).foregroundColor(color)
    })
  }
}
