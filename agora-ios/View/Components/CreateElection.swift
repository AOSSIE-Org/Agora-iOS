//
//  CreateElection.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/20/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import RealmSwift

struct CreateElection: View {
    var body: some View {
        ZStack {
           
            VStack{
                Mid_Elections().navigationBarTitle("New Election",displayMode: .inline)
            }
        }
    }
}


struct Mid_Elections: View{
    
    @State var userName = "Siddharth"
    @State var title:String = ""
    @State var place:String = ""
    @State var isAllDay:Bool = false
    @State private var start = Date()
    @State private var end = Date()
    @State var timeZone:String = ""
    
    @State var Reminder:String = ""
    @State var eleColor:String = ""
    
    @State var electionDescription:String = ""
    
    @State var candidates:String = ""
    
    
    @State private var wakeUp = Date()
    @State var isStart:Bool = false
    @State var isEnd:Bool = false
    
    var body: some View {
        
        VStack {
            ZStack {
                
                HStack {
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("Color2_2"), Color("Color2")]), startPoint: .bottom, endPoint: .top).frame(width: UIScreen.main.bounds.width , height: 176, alignment: .center)
                    }
                    
                }
                
                HStack {
                    Text("Add Elections").font(.largeTitle).foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding(.top,10)
                        .padding(.bottom,10)
                    
                    Button(action: {
                        
                        let config = Realm.Configuration(schemaVersion : 4)
                        do{
                            let realm = try Realm(configuration: config)
                            let newdata = DatabaseElection()
                            newdata._id = UUID().uuidString
                            newdata.title = self.title
                            newdata.place = self.place
                            newdata.isAllDay = self.isAllDay
                            newdata.start = self.start
                            newdata.end = self.end
                            newdata.timeZone = self.timeZone
                            newdata.Reminder = self.Reminder
                            newdata.eleColor = self.eleColor
                            newdata.electionDescription = self.electionDescription
                            try realm.write({
                                
                                realm.add(newdata)
                                print("Election details added successfully")
                            })
                            
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                        
                        
                    }, label: { Text("Save").font(.title).foregroundColor(.white)})
                }
            }

            ScrollView {
                
                
                VStack {
                    HStack {
                        Image(systemName: "list.dash").padding()
                        TextField("Title", text: $title).frame(minWidth: 0, maxWidth: 380, alignment: .center)
                    }
                    Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                    HStack {
                        Image(systemName: "pin").padding()
                        TextField("Place", text: $place).opacity(0.9)
                    }
                    
                    }.background(Color(.white)).frame(minWidth: 0, maxWidth: 380, alignment: .center).cornerRadius(10)
                
                
                VStack {
                    HStack {
                        Image(systemName: "calendar").padding()
                        //checkbox
                        Button(action: {self.isAllDay = !self.isAllDay}){
                            HStack{
                                Text("All Day")
                                Spacer()
                                Image(systemName: isAllDay ? "checkmark.square.fill": "square").resizable().foregroundColor(Color("Color2")).frame(width: 16, height: 16, alignment: .trailing).padding()
                                
                            }
                        }
                        
                    }
                    VStack{
                        Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                        HStack {
                            
                            if(self.isStart){
                                toggleButton(givenStateObject: $isStart, outputString: "Done")
                            }else if(self.isStart == false){
                                Image(systemName: "clock").padding()
                                toggleButton(givenStateObject: $isStart, outputString: "Start")
                            }
                            
                            
                            
                            VStack{
                                if(self.isStart){
                                    DatePicker("start", selection: $start, in: Date()...).labelsHidden()
                                }
                            }
                            
                            
                        }
                        
                        //For End Date
                        Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                        HStack {
                            
                            if(self.isEnd){
                                toggleButton(givenStateObject: $isEnd, outputString: "Done")
                            }else if(self.isEnd == false){
                                Image(systemName: "clock").padding()
                                toggleButton(givenStateObject: $isEnd, outputString: "End")
                            }
                                
                            
                            
                            VStack{
                                
                                if(self.isEnd){
                                    DatePicker("End", selection: $end, in: Date()...).labelsHidden()
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                   
                    Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                    HStack {
                        
                        Image(systemName: "globe").padding()
                        TextField("Time Zone", text: $timeZone).opacity(0.9)
                    }
                    Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                    HStack {
                        
                        Image(systemName: "bell").padding()
                        TextField("Reminder", text: $Reminder).opacity(0.9)
                    }
                    Divider().frame(minWidth: 0, maxWidth: 320, alignment: .center)
                    HStack {
                        
                        Image(systemName: "paintbrush").padding()
                        TextField("Color", text: $eleColor).opacity(0.9)
                    }
                    
                    
                }.background(Color(.white)).frame(minWidth: 0, maxWidth: 380, alignment: .center).cornerRadius(10)
                

                
                TextField("Description", text: $electionDescription).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Candidates", text: $candidates).textFieldStyle(RoundedBorderTextFieldStyle())
                
            }
        }.edgesIgnoringSafeArea(.top)
        
    }
    
}

struct toggleButton:View {
    @Binding var givenStateObject:Bool
    var outputString:String
    
    var body: some View{
        Button(action: {
            self.givenStateObject.toggle()
        }) {
            Text(outputString)
        }
    }
}



struct CreateElection_Previews: PreviewProvider {
    static var previews: some View {
        CreateElection()
    }
}
