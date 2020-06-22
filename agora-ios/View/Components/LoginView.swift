//
//  LoginView.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/22/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//
import SwiftUI
import RealmSwift
import AuthenticationServices


struct LoginView: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var body: some View {

        return VStack{
            if status == true{
                
                Navigation()
            }
            else{
                
                NavigationView{
                    // ScrollView based on height
                    
                    VStack(spacing:0) {
                        
                        VStack(spacing:0) {
                            ZStack {
                                TopCircleShape()
                                
                                GeometryReader { geo in
                                    
                                    Image("boy_ship")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width * 0.90, height: geo.size.height, alignment: .center)
                                }
                                
                            }
                        }
                        Spacer()
                        
                        FirstPage()
                            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                        
                    }.edgesIgnoringSafeArea(.top)
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
    
    
    @State var showSecond :Bool = false
    @State var showAuth :Bool = false
    @State var msg = ""
    @State var alert :Bool = false
    var body: some View{
        
        
        VStack(spacing:20){
            
            Text("Don't just be there,\nbe present").font(.largeTitle).fontWeight(.medium)
            
            NavigationLink(destination: SignUpView(showSecond: self.$showSecond), isActive: $showSecond){
                Button(action: {
                    //                            self.ID = ID
                    self.showSecond.toggle()
                }
                    
                ){
                    Text("GET STARTED").foregroundColor(.black).frame(width: UIScreen.main.bounds.width * 0.70,height: 50)
                }.foregroundColor(.white)
                    .background(Color.yellow)
                    .cornerRadius(20)
                
                
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
            NavigationLink(destination: AuthenticateView(showAuth: self.$showAuth), isActive: $showAuth){
                Button(action: {
                    //                            self.ID = ID
                    self.showAuth.toggle()
                }
                    
                ){
                    Text("Login").foregroundColor(.black).frame(width: UIScreen.main.bounds.width * 0.70,height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.yellow, lineWidth: 4)
                    )
                }
                
            }
            
            
        }.padding(.bottom)
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
                
        }
        
    }
}



struct SignUpView: View{
    @Binding var showSecond:Bool
    
    @State var email:String = ""
    @State var pass:String = ""
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var userName:String = ""
    @State var userSelectedQuestion:String = ""
    @State var userAnswer:String = ""
    
    var body: some View{
        ZStack(alignment:.topLeading){
            GeometryReader{geo in
                
                VStack(alignment: .leading){
                    
                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    UserTextField(fieldName: "User Name", userField: self.$userName)
                    HStack {
                        UserTextField(fieldName: "First Name", userField: self.$firstName).frame(width: geo.size.width/2)
                        UserTextField(fieldName: "Last Name", userField: self.$lastName).frame(width: geo.size.width/2)
                    }
                    HStack {
                        UserTextField(fieldName: "Secret Answer", userField: self.$userAnswer)
                        Text("Secret Question").foregroundColor(.blue)
                            .contextMenu {
                                ForEach(userQuestions, id: \.self){question in
                                    Button(action: {self.userSelectedQuestion = question}) {
                                        Text(question)}}}
                    }
                    UserTextField(fieldName: "Password", secure:true, userField: self.$email)
                    
                    
                    UserTextField(fieldName: "Email", userField: self.$email)
                    Button(action: {}) {
                        Text("Sign up").foregroundColor(.black).frame(width: geo.size.width,height: 50).foregroundColor(.white)
                            .background(Color.yellow)
                            .cornerRadius(20)
                        
                    }
                    
                }.padding()
                
            }
            
            Button(action: {
                self.showSecond.toggle()
            }
            ){
                
                Image(systemName: "chevron.left").font(.title)
                
            }.foregroundColor(.orange)
            
        }
        .padding()
    }
}



struct AuthenticateView:View {
    
    @Binding var showAuth:Bool
    
    
    @State var email:String = ""
    @State var pass:String = ""
    @State var remember:Bool = true
    
    @State var alert:Bool = false
    @State var msg:String = ""
    @State var height:CGFloat = 0
    
    @State var activityShow:Bool = false
    
    // Facebook
    @ObservedObject var fbManager = UserLoginManager()
    
    var body: some View{
        
        ZStack(alignment:.topLeading){
            
            GeometryReader{geo in
                
                ScrollView(UIScreen.main.bounds.height < 750 ? . vertical :(self.height == 0 ? .init(): .vertical),showsIndicators: false){
                    VStack(spacing:5){
                        
                        Image("login_tree").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width * 0.60, height: geo.size.height/3, alignment: .center)
                        
                        
                        
                        //MARK: Login
                        VStack(alignment: .leading){
                            Text("Login")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Username")
                                .fontWeight(.bold)
                                .padding(.top,20)
                            VStack{
                                TextField("",text: self.$email)
                                Rectangle().fill(self.email == "" ? Color.black.opacity(0.08):Color.yellow)
                                    .frame(height:3)
                            }
                            Text("Password")
                                .fontWeight(.bold)
                                .padding(.top,20)
                            VStack{
                                SecureField("",text: self.$pass)
                                Rectangle().fill(self.pass == "" ? Color.black.opacity(0.08):Color.yellow)
                                    .frame(height:3)
                            }
                        }
                        HStack{
                            
                            Button(action: {
                                self.remember.toggle()
                            }){
                                HStack(spacing:10){
                                    ZStack{
                                        Circle()
                                            .stroke(LinearGradient(gradient: Gradient(colors: [Color("Color2"), Color("Color1")]), startPoint: .top, endPoint: .bottom))
                                            .frame(width:20,height:20)
                                        
                                        if self.remember{
                                            Circle()
                                                .fill(Color("Color2"))
                                                .frame(width: 10, height: 10)
                                        }
                                    }
                                    Text("Remember me")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                }
                            }
                            Spacer()
                            Button(action: {
                                
                            }){
                                Text("Forgot Password?")
                            }
                        }
                        
                        //MARK: Social Login Buttons
                        
                        // AppleID
                        Button (action: {}) {
                            AppleIdButton().background(Color.primary).clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous)).padding(7).frame(width: geo.size.width * 0.80, height: geo.size.height * 0.10)
                        }
                        // Facebook
                        Button (action: {
                            
                            let semaphore = DispatchSemaphore(value: 0)
                            
                            self.fbManager.facebookLogin(){
                                self.activityShow = true
                                DispatchQueue.global().async {
                                    /// Concurrently execute a task using the global concurrent queue. Also known as the background queue.
                                    ElectionManager.apiService.userLoginSocial(endpoint: .authenticate(provider: "facebook")){
                                         semaphore.signal()
                                     }
                                    _ = semaphore.wait(timeout: .distantFuture)
                                     ElectionManager.apiService.getUserInfo(){
                                         semaphore.signal()
                                     }
                                     
                                    _ = semaphore.wait(timeout: .distantFuture)
                                    ElectionManager.apiService.getElection(endpoint: .electionGetAll, ID: ""){
                                        semaphore.signal()
                                    }
                                    _ = semaphore.wait(timeout: .distantFuture)
                                    // If got userXAUTH login
                                    UserDefaults.standard.set(true, forKey: "status")
                                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                }
                            }
                           
                            
                        }) {
                            FacebookButton().background(Color.primary).clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous)).padding(7).frame(width: geo.size.width * 0.80, height: geo.size.height * 0.10)
                        }
                        
                        
                        
                        //button
                        Button(action: {
                            
                            // Show Activity Indicator
                            self.activityShow = true
                            
                            // Login, get auth token and get elections
                            ElectionManager.apiService.userLogin(username: self.email.lowercased(), password: self.pass, endpoint: .login, onFailure: {
                                self.activityShow = false
                                self.alert = true
                            }){
                                
                                
                                ElectionManager.apiService.header = [
                                    //AUTH Key
                                    "X-Auth-Token": "\(UserDefaults.standard.string(forKey:"userXAUTH"))"]
                                
                                self.activityShow = false
                                
                                // Get all elections and store in db onSuccess
                                ElectionManager.getAllElections {
                                    // If got userXAUTH login
                                    UserDefaults.standard.set(true, forKey: "status")
                                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                }
                                
                                
                            }
                            
                            
                        }){
                            Text("Sign In").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                            
                        }.foregroundColor(.black)
                            .background(Color.yellow)
                            .cornerRadius(20)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    }
                    
                }.padding(.bottom,self.height) // Move view according to keyboard
                    .edgesIgnoringSafeArea(.all)
                    .onAppear(){
                        
                        // MARK: Keyboard
                        // Show Keyboard remove outside safearea height
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main){
                            (not) in
                            let data = not.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                            let height = data.cgRectValue.height - (UIApplication.shared.windows.first?.safeAreaInsets.bottom)!
                            
                            self.height = height
                            
                            print(height)
                        }
                        // Hide Keyboard
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main){
                            (_) in
                            print("Keyboard Hidden")
                            self.height = 0
                        }
                }
                
            }
            
            Button(action: {
                self.showAuth.toggle()
            }
            ){
                Image(systemName: "chevron.left").font(.title)
                
            }.foregroundColor(.orange)
            
            if self.activityShow == true{
                ActivityIndicator()
            }
            
        }
        .padding()
        .alert(isPresented: $alert) {
            Alert(title: Text("Incorrect username and / or password."), message: Text(self.msg), dismissButton: .default(Text("Ok")))
            
        }
        
    }
    
}


// MARK: Secret Questions
let userQuestions:[String] = ["What is your Mother's maiden name?","What is the name of your first pet?","What is your nickname?","Which elementary school did you attend","What is your hometown?"]




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
            SignUpView(showSecond: .constant(true))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
            
            AuthenticateView(showAuth: .constant(true))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
            
        }
    }
}

