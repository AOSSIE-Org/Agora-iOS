//
//  Settings.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/22/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @State private var showingAlert = false
    
    var body: some View {
        VStack() {
            SettingsTop()
            Text("Settings").font(.title).fontWeight(.bold)
            Divider().offset(y:4)
            ZStack {
                Color.black.opacity(0.04)
                VStack(alignment:.leading,spacing: 20){
                    Text("Manage Data").fontWeight(.bold).opacity(0.8)
                    Divider()
                    Text("Manage Account").fontWeight(.bold).opacity(0.8)
                    Divider()
                    Text("Rate Us").fontWeight(.bold).opacity(0.8)
                    Divider()
                    Text("Contact Us").fontWeight(.bold).opacity(0.8)
                    Divider()
                    Button(action: {
                        self.showingAlert = true;
                        
                    }) {
                        Text("Logout")
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Log out?"), message: Text("Are you sure you want to log out?"),primaryButton: .default(Text("Yes"), action: {
                            print("Logging out...")
                            
                            
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                            
                        }), secondaryButton: .default(Text("Dismiss")))
                    }
                }.padding(.leading,20)
            }
            Spacer()
        }
    }
}

struct SettingsTop:View{
    @State var name = "Name"
    @State var email = "xyz@gmail.com"
    var body : some View{
        
        VStack(spacing:0){
            ZStack(){
                    Image("Mountains")
                HStack(){
                    Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color("Color2"), Color("Color1")]), startPoint: .top, endPoint: .bottom), lineWidth: 4)
                        .frame(width:64,height:64)
                        .background(Text("SS").font(.title).fontWeight(.bold))

                    Text(self.name + "\n" + self.email)
                    Spacer()
                }.padding()
            }.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
        }.edgesIgnoringSafeArea(.top).padding(.leading,20)
    }
}



struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Group {
                       Settings()
                          .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                          .previewDisplayName("iPhone 8")

                       Settings()
                          .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                          .previewDisplayName("iPhone 11")
                    }
    }
}
