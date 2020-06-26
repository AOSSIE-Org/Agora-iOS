//
//  CardView.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/19/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import Combine
import RealmSwift



class BindableResults<Element>: ObservableObject where Element: RealmSwift.RealmCollectionValue {
    
    var results: Results<Element>
    private var token: NotificationToken!
    
    init(results: Results<Element>) {
        self.results = results
        lateInit()
    }
    
    func lateInit() {
        token = results.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    deinit {
        token.invalidate()
    }
}




struct CardView : View {
    let config = Realm.Configuration(schemaVersion : 4)
    
    @ObservedObject var elections = BindableResults(results: try! Realm(configuration: Realm.Configuration(schemaVersion : 4)).objects(DatabaseElection.self))
    
    @State var activateLink: Int? = 0
    
    var body: some View {
        
       Group {
            ScrollView {
                VStack(alignment: .center) {
                    
                    ForEach(self.elections.results, id: \.id) { item in
                        drawCard(actionDrawCard: self.$activateLink, cardTitle: item.title, place: item.place, isAllDay: item.isAllDay, timeZone: item.timeZone, numberRepeat: item.numberRepeat, Reminder: item.Reminder, eleColor: item.eleColor, detailText: item.electionDescription, candidates: "test")
                    }
                }
            }
        }.onAppear(){
            
            do{
                let realm = try Realm(configuration: self.config)
                let  result = realm.objects(DatabaseElection.self)
                
                print(result)
                
                
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}


struct drawCard:View {
    
    //Binding
    @Binding var actionDrawCard:Int?
    @State var show = false

    
    let cardTitle:String
    let place:String
    let isAllDay:Bool
    let start = Date()
    let end = Date()
    let timeZone:String
    let numberRepeat:String
    let Reminder:String
    let eleColor:String
    let detailText:String
    let candidates:String
    
    
    var body: some View{
        
        VStack() {
            
            HStack(alignment: .top) {
                Text(cardTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .padding(.top, show ? 10 : 5)
                    .padding(.bottom, show ? 10 : 0)
                
                Spacer()
                Text(place)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .opacity(0.75)
                    .padding(.top, show ? 10 : 5)
                    .padding(.bottom, show ? 10 : 0)
            }
            
            
            Text(detailText)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .animation(.spring())
                .lineLimit(.none)
            Spacer()
            
            Button(action: {
                self.show.toggle()
            }) {
                HStack {
                    Spacer()
                    Image(systemName: show ? "arrowtriangle.down.fill" : "arrowtriangle.down")
                        .foregroundColor(Color(.white))
                        .font(Font.title.weight(.semibold))
                        .imageScale(.small)
                }
            }
            .padding(.bottom, show ? 20 : 15)
            
        }
        .padding()
        .padding(.top, 15)
        .frame(width: show ? 350 : 350, height: show ? 220 : 80)
        .background(Color(eleColor))
        .cornerRadius(10)
        .shadow(radius: 20)
        .animation(.spring())
    }
    
}



#if DEBUG
struct CardView_Previews : PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
#endif


