//
//  Settings.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/22/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import RealmSwift

struct Settings: View {
    @State private var showingAlert = false
    @State private var showingContact:Bool = false
    @ObservedObject var fbManager = UserLoginManager()
    var body: some View {
        VStack() {
            SettingsTop()
            Text("Settings").font(.title).fontWeight(.bold)
            Divider().offset(y:4)
            ZStack {
                Color.black.opacity(0.04)
                VStack(alignment:.leading,spacing: 20){
                    Button(action: {}) {
                        Text("Manage Data").fontWeight(.bold).foregroundColor(Color.black).opacity(0.8)
                    }
                    Divider()
                    Button(action: {}) {
                        Text("Manage Account").fontWeight(.bold).foregroundColor(Color.black).opacity(0.8)
                    }
                    Divider()
                    Button(action: {}) {
                        Text("Rate Us").fontWeight(.bold).foregroundColor(Color.black).opacity(0.8)

                    }
                    Divider()
                    Button(action: {self.showingContact.toggle()}) {
                        Text("Contact Us").fontWeight(.bold).foregroundColor(Color.black).opacity(0.8)
                    }
                    Divider()
                    Button(action: {
                        self.showingAlert = true;
                        
                    }) {
                        Text("Logout")
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Log out?"), message: Text("Are you sure you want to log out?"),primaryButton: .default(Text("Yes"), action: {
                            print("Logging out...")
                            
                            ElectionManager.deleteAllElectionsfromdb {
                                
                                UserDefaults.standard.set(false, forKey: "status")
                                self.fbManager.loginManager.logOut()
                                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                
                                UserDefaults.standard.set("", forKey: "userXAUTH")
                            }
        
                        }), secondaryButton: .default(Text("Dismiss")))
                    }
                }.padding(.leading,20)
            }
            Spacer()
        }.sheet(isPresented:$showingContact){
            VStack{
                Text("Contact Info Here!")
            }
        }
    }
}

struct SettingsTop:View{
    @State var name = Credentials.username
    @State var email = Credentials.email
    @State var firstName = Credentials.firstName
    @State var lastName = Credentials.lastName
    
    @ObservedObject var userResults = BindableResults(results: try! Realm(configuration: Realm.Configuration(schemaVersion : 4)).objects(DatabaseUser.self))
    
    
    var body : some View{
        
        VStack(spacing:0){
            ZStack(){
                    Image("Mountains")
                HStack(){
                    Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color("Color2"), Color("Color1")]), startPoint: .top, endPoint: .bottom), lineWidth: 4)
                        .frame(width:64,height:64)
                        .background(Text("\(userResults.results[0].firstName)\(userResults.results[0].lastName)").font(.title).fontWeight(.bold))

                    Text(userResults.results[0].username + "\n" + userResults.results[0].email)
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
