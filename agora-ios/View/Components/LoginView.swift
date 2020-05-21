//
//  LoginView.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/22/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//
import SwiftUI


struct LoginView: View {
    
    ///Auto Resize UI Elements on keyboard active
   // @ObservedObject var keyboardHandler: KeyboardFollower

//    init(keyboardHandler: KeyboardFollower) {
//      self.keyboardHandler = keyboardHandler
//    }

    
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var body: some View {
        
        VStack{
            if status{
                
                Navigation()
            }
            else{
                
                NavigationView{
                    //if status not true
                    DashboardView()
                }
            }
        }.onAppear{
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                
                self.status = status
            }
        }
        
        
       
    }
}


struct FirstPage: View{
    
   // @ObservedObject var keyboardHandler: KeyboardFollower
//    init(keyboardHandler: KeyboardFollower) {
//      self.keyboardHandler = keyboardHandler
//    }
    
    
    @State var cCode = ""
    @State var registerUserNumber = ""
    @State var show :Bool = false
    @State var msg = ""
    @State var alert :Bool = false
    @State var ID = ""
    var body: some View{
        
        
        VStack(spacing:20){
            
            Image("img_mail").resizable().clipped()
            
            Text("Verify Your Number").font(.largeTitle).fontWeight(.heavy)
            
            Text("Please enter your phone number to verify your account!")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top,12)
            
            HStack{
                TextField("+1",text: $cCode)
                    .keyboardType(.numberPad)
                               .frame(width:45)
                               .padding()
                               .background(Color("myColor1"))
                               .clipShape(RoundedRectangle(cornerRadius: 10))
                              
                
                TextField("Number",text: $registerUserNumber)
                               .padding()
                               .background(Color("myColor1"))
                               .clipShape(RoundedRectangle(cornerRadius: 10))
            } .padding(.top,15)
            
            
            NavigationLink(destination: SecondPage(show: $show,ID: $ID), isActive: $show){
                
                
                         Button(action: {
                
//                            self.ID = ID
                                self.show.toggle()
                                
                            }

                         ){
                             Text("Send").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                         }.foregroundColor(.white)
                         .background(Color.orange)
                          .cornerRadius(10)
                
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            
        }.padding(.bottom)
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
                
               

        }
        
    }
}



struct SecondPage: View{
    
    @State var Code:String = ""
    @Binding var show:Bool
    @Binding var ID:String
    @State var msg:String = ""
    @State var alert = false
    
    var body: some View{
        
        ZStack(alignment:.topLeading){
            GeometryReader{_ in
                
                VStack(spacing:20){
                    
                    Image("img_mail").resizable().clipped()
                    
                    Text("Verification Code").font(.largeTitle).fontWeight(.heavy)
                    
                    Text("Enter your verification code!")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top,12)
                    
                    TextField("Code",text: self.$Code)
                            .keyboardType(.numberPad)
                                       .padding()
                                       .background(Color("myColor1"))
                                       .clipShape(RoundedRectangle(cornerRadius: 10))
                                       .padding(.top,15)
                    
                    
                    //button
                    Button(action: {
                            UserDefaults.standard.set(true, forKey: "status")
                            
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                            
                        
                        
                    }){
                        Text("Verify").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                    }.foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    //end
                    
                }
                
            }
            
            
            Button(action: {
                self.show.toggle()
                }
                ){
                
                Image(systemName: "chevron.left").font(.title)
                
            }.foregroundColor(.orange)
            
        }
        
        
        .padding()
        .alert(isPresented: $alert) {
                       Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        
    }
    
}
}


struct Home:View {
    var body:some View{
        
        VStack{
            Text("Home")
            
            Button(action: {
                
              
                
                UserDefaults.standard.set(false, forKey: "status")
                
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                
                
            }) {
                Text("Logout")
            }
            
        }
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
