//
//  ElectionResultView.swift
//  agora-ios
//
//  Created by Siddharth sen on 7/21/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import UserNotifications

struct ElectionDetailsView: View {
    @ObservedObject var calendarManager:CalendarManager
    
    
    var body: some View {
        
        return
            VStack() {
            ZStack {
                HStack(spacing:10) {
                    
                    Button(action: { self.calendarManager.eventUpdateOverlayShow.toggle() }
                    ){
                        Image(systemName: "multiply.circle.fill").font(.title)
                    }.foregroundColor(.white)
                    Spacer()
                }.background(LinearGradient(gradient: Gradient(colors: [Color("Color2_2"), Color("Color2")]), startPoint: .bottom, endPoint: .top).frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 6 , alignment: .center).edgesIgnoringSafeArea(.top))
                Text(calendarManager.election[0].name)
                    .foregroundColor(.white)
                    .fontWeight(.regular)
                    .font(.title)
            }.padding()
            
            HStack {
                Spacer()
                Button(action: {}){
                    Text("Show Election Results").frame(width: UIScreen.main.bounds.width / 1.4 ,height: 50).foregroundColor(.white)
                    
                }.customButton(width: UIScreen.main.bounds.width / 1.4)
                
                Spacer()
            }.padding(.top,20).padding(.bottom,5)
            
            HStack {
                Spacer()
                Button(action: {self.addNotification(for: self.calendarManager.election[0])}){
                    Text("Remind Me").frame(width: UIScreen.main.bounds.width / 1.4 ,height: 50).foregroundColor(.white)
                    
                }.customButton(width: UIScreen.main.bounds.width / 1.4)
                
                Spacer()
            }
            
            Divider()
            
                ScrollView(.vertical, showsIndicators: false) {
                
                    Text("Election Name: " + calendarManager.election[0].name)
                    .fontWeight(.medium)
                    .padding(.top,10)
                    .padding(.bottom,10)
                    Text("Election description: " + calendarManager.election[0].description)
                    .fontWeight(.medium)
                       
                        .multilineTextAlignment(.leading)
                    .padding(.top,10)
                    .padding(.bottom,10)
                    Text("Algorithm: " + calendarManager.election[0].votingAlgo)
                    .fontWeight(.medium)
                   
                    .padding(.top,10)
                    .padding(.bottom,10)
                    Text("Start : " + dateToReadableStringDateFormatter(date: calendarManager.election[0].startingDate) + "\nEnd : " + dateToReadableStringDateFormatter(date: calendarManager.election[0].endingDate))
                    .fontWeight(.medium)
                    
                    .padding(.top,10)
                    .padding(.bottom,10)
                Text("Election Type: " + "\(calendarManager.election[0].electionType)")
                    .fontWeight(.medium)
                    .padding(.top,10)
                    .padding(.bottom,10)
                Text("Candidates").fontWeight(.semibold)
                .font(.footnote)
                .padding(.top,10)
                .padding(.bottom,10)
                List(calendarManager.election[0].candidates,id: \.self){ candidate in
                    CandidateBadge(candidateName: candidate)
                    }.frame(width: UIScreen.main.bounds.width * 0.9, height: 400, alignment: .center).cornerRadius(10)
                    
                   
            }.padding(.top, 10)
            .padding(.leading,10)
            .frame(width:UIScreen.main.bounds.width - 20)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        
            Spacer()
            
            }
    }
    
    
    func addNotification(for election: Election) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = election.name
            content.subtitle = dateToReadableStringDateFormatter(date: election.startingDate)
            content.sound = UNNotificationSound.default
            
            // A day before starting date of election
            var futureDate = election.startingDate
            futureDate.changeDays(by: -1)
            
            var dateComponents = DateComponents()

            dateComponents.day = futureDate.day
            dateComponents.hour = futureDate.hour
            dateComponents.year = futureDate.year
            dateComponents.minute = futureDate.minute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            center.add(request)
            
        }
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge,.sound]) { (success, error) in
                    if success {
                        addRequest()
                    } else {
                        print("requestAuthorization Failed!")
                    }
                }
            }
        }
        
    }
    
}

struct CandidateBadge: View {
    var candidateName:String = ""
    var body: some View {
        VStack(spacing:0){
                HStack(){
                    Circle()
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color("Color2"), Color("Color1")]), startPoint: .top, endPoint: .bottom), lineWidth: 4)
                        .frame(width:64,height:64)
                        .background(Text("\(candidateName.substring(to: candidateName.index(candidateName.startIndex, offsetBy: 2)))").font(.title).fontWeight(.bold))
                    Text(candidateName)
                    Spacer()
                }.padding()
        }
    }
}

struct ElectionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ElectionDetailsView(calendarManager: CalendarManager())
    }
}
