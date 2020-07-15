//
//  CalendarDisplayView.swift
//  agora-ios
//
//  Created by Siddharth sen on 7/4/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import SwiftUI
import KVKCalendar
import RealmSwift


struct CalendarDisplayView: UIViewRepresentable {
    @ObservedObject var databaseElectionEvents = BindableResults(results: try! Realm(configuration: Realm.Configuration(schemaVersion : 4)).objects(DatabaseElection.self))
    
    var selectDate: Date?
    public init(selectDate: Date?) {
        self.selectDate = selectDate
    }
    private var calendar: CalendarView = {
        
        var style = Style()
        if UIDevice.current.userInterfaceIdiom == .phone {
            style.month.isHiddenSeporator = true
            style.timeline.widthTime = 40
            style.timeline.offsetTimeX = 2
            style.timeline.offsetLineLeft = 2
            style.timeline.eventCornersRadius = CGSize(width: 8, height: 8)
            style.timeline.startFromFirstEvent = true
        } else {
            style.timeline.widthEventViewer = 500
        }
        style.timeline.startFromFirstEvent = false
        style.timeline.offsetTimeY = 80
        style.timeline.offsetEvent = 3
        style.timeline.currentLineHourWidth = 40
        style.allDay.isPinned = true
        style.startWeekDay = .sunday
        style.timeHourSystem = .twelveHour
        
        return CalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: style)
        
    }()
    
    // Once when it is ready to display the view
    func makeUIView(context: UIViewRepresentableContext<CalendarDisplayView>) -> CalendarView {
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        calendar.reloadData()
        return calendar
    }
    // Update the configuration for the presented
    
    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<CalendarDisplayView>) {
        context.coordinator.eventsForCalendar()
        
        
    }
    
    // Tell SwiftUI about the Coordinator class
    func makeCoordinator() -> CalendarDisplayView.Coordinator {
        Coordinator(self, databaseElectionEvents)
    }
    
    // MARK: Calendar DataSource and Delegate
    // Bridge between the data inside SwiftUI and the external framework
    
    class Coordinator: NSObject, CalendarDataSource, CalendarDelegate {
        
        var selectDate: Date?
        private var events = [Event]()

        func eventsForCalendar() -> [Event] {
            return events
            }
        
        func loadEvents(completion: ([Event]) -> Void) {
            var events = [Event]()
            
            for (index, model) in bindableDatabase.results.enumerated() {
                var event = Event()
                event.id = index
                event.start = model.start // start date event
                event.end = model.end // end date event
                event.color = EventColor(UIColor.init(named: "Color1") ?? UIColor.blue)
                event.isAllDay = model.isAllDay
                event.isContainsFile = false
                event.textForMonth = model.title
                
                // Add text event (title, info, location, time)
                if model.isAllDay {
                    event.text = "\(model.title)"
                } else {
                    event.text = "\(model.start) - \(model.end)\n\(model.title)"
                }
                events.append(event)
                
            }
            completion(events)
        }
        
        func formatter(date: String) -> Date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            return formatter.date(from: date) ?? Date()
        }
        
        func timeFormatter(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
        
        func willDisplayDate(_ date: Date?, events: [Event]) -> DateStyle? {
            // DateStyle
            // - backgroundColor = cell background color
            // - textColor = cell text color
            // - dotBackgroundColor = selected date dot color
            return DateStyle(backgroundColor: UIColor.init(named: "Color2_2") ?? .clear, textColor: .white, dotBackgroundColor: .systemRed)
        }
        
        func didSelectDate(_ date: Date?, type: CalendarType, frame: CGRect?) {
            selectDate = date ?? Date()
            loadEvents { (events) in
                self.events = events
                self.view.calendar.reloadData()
            }
        }
        
        
        
        private let view: CalendarDisplayView
        private let bindableDatabase:BindableResults<DatabaseElection>
        
        init(_ view: CalendarDisplayView,_ databaseResult:BindableResults<DatabaseElection>) {
            self.view = view
            self.bindableDatabase = databaseResult
            super.init()
            
            loadEvents { (events) in
                self.events = events
                self.view.calendar.reloadData()
            }
        }
        
        
    }
}

struct CalendarDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDisplayView(selectDate: Date())
    }
}
