//
//  DashboardView.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/19/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import RealmSwift


struct DashboardView: View {
    
    @State var activeLink:Int = 0
    
   
    var body: some View {
        
        
        
            VStack {
                        Top_Dashboard()
                        Spacer()
                Mid_Dashboard().offset(y:-3)
      
            }
     

    }
}

// MARK: Top:-
struct Top_Dashboard: View {
    @State var userName = "Siddharth"
    var body : some View{
        
        VStack(spacing:0){
            HStack(){
                Text("     Hello,\n" + userName).fontWeight(.medium)
                                                .opacity(0.8)
                                                   .font(.largeTitle)
                                                   .padding(.top,10)
                                                   .padding(.bottom,10)
                    .offset(x:UIScreen.main.bounds.width / 3 - 10)
                
                Spacer()
                
                Button(action: {}, label: { Image(systemName: "plus").resizable().frame(width: 32, height: 32,alignment: .topTrailing).foregroundColor(.white).offset(x:-20,y:-20).onTapGesture {
                                            //perform some tasks if needed before opening Destination view
                                        print("New Election Tapped")
                                    }})
                
            }.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color("Color1"), Color("Color2")]), startPoint: .topLeading, endPoint: .bottomTrailing).clipShape(RoundedRectangle(cornerRadius: 30, style: .circular)).frame(width: UIScreen.main.bounds.width, height: 150)
                    Image("Mountains").offset(y:-10)
                })
        }.edgesIgnoringSafeArea(.top)
        
    }
}



//
//      return  VStack {
//
//                LinearGradient(gradient: Gradient(colors: [Color("Color1"), Color("Color2")]), startPoint: .topLeading, endPoint: .bottomTrailing).frame(width: UIScreen.main.bounds.width , height: 176, alignment: .center).clipShape(RoundedRectangle(cornerRadius: 30, style: .circular)).offset(x: 0, y: -10)
//                Image("Mountains")
//
//                HStack {
//                    Text("     Hello,\n" + userName).foregroundColor(.black)
//                                   .fontWeight(.bold)
//                                   .font(.largeTitle)
//                                   .padding(.top,10)
//                                   .padding(.bottom,10)
//
//
//
//
//                    Button(action: {}, label: { Image(systemName: "plus").resizable().frame(width: 32, height: 32,alignment: .topTrailing).foregroundColor(.white).onTapGesture {
//                            //perform some tasks if needed before opening Destination view
//
//
//                        print("New Election Tapped")
//                    }})
//                }
//
//          //
//            }
//
//      }
//
//
//}





// MARK: Mid:-
struct Mid_Dashboard: View{
    @State var inputSearch:String = ""
    @State var electionCountMid:Int = 5
    
    //Realm
    let config = Realm.Configuration(schemaVersion : 3)
    @ObservedObject var elections = BindableResults(results: try! Realm(configuration: Realm.Configuration(schemaVersion : 3)).objects(DatabaseElection.self))
    
    var body: some View {
        VStack {
            SearchBar(text:$inputSearch).frame(width:UIScreen.main.bounds.width - 60,height:40)
            Rectangle().frame(width: 350, height: 5, alignment: .center).foregroundColor(Color(.gray)).opacity(0.7)
            ScrollView.init(.vertical, showsIndicators: false) {
                StaticCard(headerText: "Total Elections", numberElections:electionCountMid , myColor: "_Purple")
                StaticCard(headerText: "Upcoming Elections", numberElections: 4,myColor: "Blue")
                StaticCard(headerText: "Pending Elections", numberElections: 4,myColor: "Pink")
                StaticCard(headerText: "Finished Elections", numberElections: 4,myColor: "Red")
            }
            
        }.onAppear(){

                do{
                    let realm = try Realm(configuration: self.config)
                    let  result = realm.objects(DatabaseElection.self)
                    
                    
                    for _ in result {
                        self.electionCountMid += 1
                        print("REALM: Total Records \(self.electionCountMid)")
                    }
                    
                    
                    
                    print(result)
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
        }
    
    }

}

struct StaticCard: View {
    @State var headerText:String = "Total Elections"
    @State var numberElections:Int = 5
    @State var myColor:String = "Blue"
    var body:some View{
        HStack {
            HStack{
                Text(headerText)
                                   .foregroundColor(.white)
                                   .fontWeight(.bold)
                    .font(.largeTitle)
                                   .padding(.top,10)
                                   .padding(.bottom,10)
                Spacer()
                
                Text("\(numberElections)")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.top,10)
                .padding(.bottom,10)
                    .opacity(0.8)
                
                
            }.padding()
            .padding(.top, 15)
                //UIScreen.main.bounds.width / 2 - 20
                .frame(width:UIScreen.main.bounds.width - 20,height:120)
                .background(Color(myColor))
            .cornerRadius(10)
                .shadow(color: .gray, radius: 6, x: 0, y: 2)
                .animation(.spring())
            
            
        }.padding(.top,20)
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
         Group {
                DashboardView()
                   .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                   .previewDisplayName("iPhone 8")

                DashboardView()
                   .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                   .previewDisplayName("iPhone 11")
             }
    }
}
