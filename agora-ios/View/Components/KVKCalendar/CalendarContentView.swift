//
//  CalendarContentView.swift
//  agora-ios
//
//  Created by Siddharth sen on 7/4/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import KVKCalendar


class CalendarManager: ObservableObject{
     var currentTypeUserSelection:Int = 0
     var currentYear:String = "2020"
}

struct CalendarContentView: View {
    @State var userSelection:Int = 0
    @ObservedObject var calendarManager:CalendarManager = CalendarManager()
    
    @State var willCallFunc = false
    
    public enum CalendarType: String, CaseIterable {
        case day, week, month, year
    }

    var body: some View {
        VStack{
            HStack(spacing: 15){
                if userSelection == 2 {Text(calendarManager.currentYear).foregroundColor(.white).fontWeight(.bold).padding(.leading,10)}
                Spacer()
                Button(action: {self.userSelection = 0;self.calendarManager.currentTypeUserSelection = 0;self.willCallFunc = true}) {
                     
                     Text("\(CalendarType.day.rawValue.capitalized)")
                        .fontWeight(.medium)
                         .foregroundColor(self.userSelection == 0 ? .white : .black)
                         .padding(.vertical, 5)
                         .padding(.horizontal, 20)
                     
                 }
                .background(self.userSelection == 0 ? Color.init("_Purple") : Color.white)
                .clipShape(Capsule())
                
                 
                Button(action: {self.userSelection = 1;self.calendarManager.currentTypeUserSelection = 1;self.willCallFunc = true}) {
                     
                     Text("\(CalendarType.week.rawValue.capitalized)")
                         .foregroundColor(self.userSelection == 1 ? .white : .black)
                         .padding(.vertical, 5)
                         .padding(.horizontal, 20)
                     
                 }
                 .background(self.userSelection == 1 ? Color.init("_Purple") : Color.white)
                 .clipShape(Capsule())
                
                 
                Button(action: { withAnimation(.easeIn){self.userSelection = 2;self.calendarManager.currentTypeUserSelection = 2;self.willCallFunc = true}}) {
                     
                     Text("\(CalendarType.month.rawValue.capitalized)")
                         .foregroundColor(self.userSelection == 2 ? .white : .black)
                         .padding(.vertical, 5)
                         .padding(.horizontal, 20)
                     
                 }
                 .background(self.userSelection == 2 ? Color.init("_Purple") : Color.white)
                 .clipShape(Capsule())
                Spacer()
             }
            .background(ZStack{LinearGradient(gradient: Gradient(colors: [Color("Color2_2"), Color("Color2")]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.top).frame(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height / 3.5, alignment: .center);Image("Mountains").resizable().scaledToFill()})
            
            
            CalendarDisplayView(selectDate: Date(), isCallingFunc: $willCallFunc, calendarManager: calendarManager)
        }
         
    }
}

struct CalendarContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarContentView(calendarManager: CalendarManager())
    }
}
