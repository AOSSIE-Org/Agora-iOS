//
//  Navigation.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/19/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI

struct Navigation: View {
    var body: some View {
        TabView{
            DashboardView().tabItem({
                Image(systemName: "house").resizable()
                Text("Home")
                }).tag(0)
            ElectionView().tabItem({
                Image(systemName: "calendar").resizable()
                Text("All")
                }).tag(1)
            Settings().tabItem({
            Image(systemName: "gear").resizable()
            Text("Settings")
            }).tag(2)
        }
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}

