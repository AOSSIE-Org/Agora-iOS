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
    @State private var showingAccountDetails:Bool = false
    @State private var showingLanguages:Bool = false
    @State private var showingTerms:Bool = false
    
    @ObservedObject var fbManager = UserLoginManager()
    var body: some View {
        
       
            VStack() {
                SettingsTop()
                Text("Settings").font(.title).fontWeight(.bold)
                Divider().offset(y:4)
                ZStack {
                    Color.black.opacity(0.04).offset(y:-4)
                    VStack{
                    VStack(alignment:.leading,spacing: 20){
                        
                        Button(action: {self.showingAccountDetails.toggle()}) {
                            SettingsButtonText(details: "Account Details")
                        }.sheet(isPresented: $showingAccountDetails) {
                                AccountDetails()
                        }
                        Divider()
                        Button(action: {}) {
                            SettingsButtonText(details: "Language")
                        }

                        
                        Divider()
                        Button(action: {}) {
                            SettingsButtonText(details: "Terms & Conditions")
                        }
                        Divider()
                        Button(action: {self.showingContact.toggle()}) {
                            SettingsButtonText(details: "About Us")
  
                        }.sheet(isPresented:$showingContact){
                            AboutUs()
                        }
                        Divider()
                    }.padding(.leading,30)

                                    Button(action: {
                                        self.showingAlert = true;
                                        
                                    }) {
                                        Text("Logout").foregroundColor(.black).frame(width: UIScreen.main.bounds.width - 20, height: 50)
                                        
                                    
                                    }.foregroundColor(.white)
                                    .background(Color.yellow)
                                    .cornerRadius(20).alert(isPresented: $showingAlert) {
                                        Alert(title: Text("Log out?"), message: Text("Are you sure you want to log out?"),primaryButton: .default(Text("Yes"), action: {
                                            print("Logging out...")
                                            
                                            DatabaseElectionManager.deleteAllElectionsfromdb {
                                                
                                                UserDefaults.standard.set(false, forKey: "status")
                                                self.fbManager.loginManager.logOut()
                                                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                                
                                               UserDefaults.standard.set("", forKey: "userXAUTH")
                                            }
                        
                                        }), secondaryButton: .default(Text("Dismiss")))
                                    }
                    }
                    
                }
                Spacer()
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
        }.padding(.leading,20)
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

    struct AccountDetails: View {
        @State private var firstName:String = Credentials.firstName
        @State private var lastName:String = Credentials.lastName
        @State private var emailAddress:String = Credentials.email
        @State private var oldPassword:String = ""
         @State private var newPassword:String = ""
        var body: some View {
            VStack(spacing:15){
                Text("Account Details").font(.largeTitle).padding(.top,10).offset(y:2)
                Divider()
                Spacer()
                UserTextField(fieldName: "First Name", defaultText: Credentials.firstName, userField: $firstName)
                UserTextField(fieldName: "Last Name", defaultText: Credentials.lastName, userField: $lastName)
                UserTextField(fieldName:"Email Address", defaultText: Credentials.email, userField: $emailAddress)
                UserTextField(fieldName:"Current Password",secure: true, defaultText: "",userField: $oldPassword)
                UserTextField(fieldName:"New Password",secure: true, defaultText: "",userField: $newPassword)
                Button(action: {
                    // Save 
                    
                }) {
                    Text("Save Details").foregroundColor(.black).frame(width: UIScreen.main.bounds.width - 10 , height: 50)
                    
                
                }.foregroundColor(.white)
                .background(Color.yellow)
                .cornerRadius(20)
                
                
                
                
            }.padding()
          
    }
}
struct AboutUs: View {
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment:.leading) {
                Text("About Us").font(.largeTitle)
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 1)
                    
                    VStack {
                        Image("logo").resizable().aspectRatio(contentMode: .fit).frame(width: geo.size.width * 0.2, height: geo.size.height * 0.2, alignment: .center)
                        Text("Agora vote is a voting platform where users can create elections and invite friends to cast their votes.It supports a wide range of voting algorithms some of which are Majority, Egalitarian, Australian STV just to name a few.").multilineTextAlignment(.center).font(.body)
                        Text("Developed by AOSSIE")
                    }
                }.frame(width: geo.size.width - 20, height: geo.size.height / 2, alignment: .center)
                ZStack{
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 2)
                    VStack(alignment: .leading) {
                        Text("Connect with AOSSIE").bold()
                        HStack{
                            Image("gitlab-logo").resizable().aspectRatio(contentMode: .fit).frame(width: geo.size.width / 4, height: 64, alignment: .leading)
                            Text("Gitlab")
                            
                        }
                    }
                }.frame(width: geo.size.width - 20, height: 128, alignment: .center)
            }
            
        }
            
        }
    }
}

struct SettingsButtonText: View {
    var details:String
    var imageName:String = "chevron.up"
    var body: some View {
        HStack {
            Text(details).fontWeight(.bold).foregroundColor(Color.black).opacity(0.8)
            
            Image(systemName: imageName).frame(width: 32, height: 32, alignment: .trailing)
        }
    }
}

