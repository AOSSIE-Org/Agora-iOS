//
//  CalendarContentView.swift
//  agora-ios
//
//  Created by Siddharth sen on 7/4/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import KVKCalendar

struct CalendarContentView: View {
    @State var userSelection:Int = 0
    var body: some View {
        VStack{
            Picker("", selection: $userSelection) {
                Text("Day").tag(0)
                Text("Week").tag(1)
                Text("Month").tag(2)
            }.pickerStyle(SegmentedPickerStyle()).labelsHidden()
            CalendarDisplayView(selectDate: Date())
        }
         
    }
}

struct CalendarContentView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarContentView()
    }
}
