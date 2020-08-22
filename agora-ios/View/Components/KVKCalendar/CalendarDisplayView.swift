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
    @ObservedObject var calendarManager: CalendarManager
    @Binding var isCallingFunc: Bool
    
    var selectDate: Date?
    public init(selectDate: Date?, isCallingFunc:Binding<Bool>, calendarManager:CalendarManager ) {
        self.selectDate = selectDate
        self._isCallingFunc = isCallingFunc
        self.calendarManager = calendarManager
    }
    private var calendar: CalendarView = {
        
        var style = Style()
        if UIDevice.current.userInterfaceIdiom == .phone {
            style.month.isHiddenSeporator = true
            style.timeline.widthTime = 40
            style.timeline.offsetTimeX = 6
            style.timeline.offsetLineLeft = 7
            style.timeline.eventCornersRadius = CGSize(width: 8, height: 8)
            style.timeline.startFromFirstEvent = true
        } else {
            style.timeline.widthEventViewer = 500
        }
        
        style.timeline.offsetTimeY = 80
        style.timeline.offsetEvent = 3
        style.timeline.currentLineHourWidth = 40
        style.allDay.isPinned = true
        style.startWeekDay = .sunday
        style.timeHourSystem = .twelveHour
        style.headerScroll.colorSelectDate = .white
        style.headerScroll.colorDate = .white
        style.headerScroll.isHiddenTitleDate = false
        style.headerScroll.isHiddenCornerTitleDate = false
        style.headerScroll.colorWeekendDate = .systemYellow
        style.headerScroll.colorBackground = .clear
        style.headerScroll.colorTitleDate = .white
        
        style.month.isHiddenTitleDate = true
        
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
        if isCallingFunc {
            context.coordinator.handleCalendarTypeSelection(uiView)
            isCallingFunc = false
        }
        
    }
    
    // Tell SwiftUI about the Coordinator class
    func makeCoordinator() -> CalendarDisplayView.Coordinator {
        Coordinator(self, databaseElectionEvents,calendarManager)
    }
    
    // MARK: Calendar DataSource and Delegate
    // Bridge between the data inside SwiftUI and the external framework
    
    class Coordinator: NSObject, CalendarDataSource, CalendarDelegate {
        
        var calendarManager: CalendarManager
        var selectDate: Date?
        private var events = [Event]()

        func eventsForCalendar() -> [Event] {
            return events
            }
        
        func loadEvents(completion: ([Event]) -> Void) {
            var events = [Event]()
            
            for (index, model) in bindableDatabase.results.enumerated() {
                var event = Event()
                event.id = model._id // election id
                event.start = model.start // start date event
                event.end = model.end // end date event
                event.color = EventColor(UIColor.init(named: "Color1") ?? UIColor.blue,alpha: 0.95)
                event.isAllDay = model.isAllDay
                event.isContainsFile = false
                event.textForMonth = model.title
                
                // Add text event (title, info, location, time)
                if model.isAllDay {
                    event.text = "\(model.title)"
                } else {
                    event.text = "\(timeFormatter(date: model.start)) - \(timeFormatter(date: model.end))\n\(model.title)"
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
            return DateStyle(backgroundColor: .clear, textColor: calendarManager.currentTypeUserSelection == 2 ? .black : .white, dotBackgroundColor: UIColor(named: "Red"))
        }
        
        func didSelectDate(_ date: Date?, type: CalendarType, frame: CGRect?) {
            selectDate = date ?? Date()
            loadEvents { (events) in
                self.events = events
                updateYear(date)
                self.view.calendar.reloadData()
            }
        }
        
        
        func didSelectEvent(_ event: Event, type: CalendarType, frame: CGRect?) {
            print(type, event)
            switch type {
            case .day:
                calendarManager.election.removeAll()
                print(event.id)
                // Get election details from db and navigate to details view
                calendarManager.getParticularElectionFromDb(id: event.id as! String)
                calendarManager.eventUpdateOverlayShow = true
                
            default:
                break
            }
        }
        
        
        private let view: CalendarDisplayView
        private let bindableDatabase:BindableResults<DatabaseElection>
        
        init(_ view: CalendarDisplayView,_ databaseResult:BindableResults<DatabaseElection>, _ calendarManager:CalendarManager ) {
            self.view = view
            self.bindableDatabase = databaseResult
            self.calendarManager = calendarManager
            super.init()
            
            loadEvents { (events) in
                self.events = events
                self.view.calendar.reloadData()
            }
        }
        
        
        func handleCalendarTypeSelection(_ uiView: CalendarView){
            let type = CalendarType.allCases[calendarManager.currentTypeUserSelection]
            uiView.set(type: type, date: selectDate ?? Date())
            // If month calendar view then resize view
            if calendarManager.currentTypeUserSelection == 2 {
                uiView.reloadFrame(CGRect(x: 0, y: 50 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height ))
            } else {
                uiView.reloadFrame(CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height ))
            }
            
            uiView.reloadData()
        }
        
        func updateYear(_ date:Date?){
            
            let toYearFormatter = DateFormatter()
            toYearFormatter.dateFormat = "YYYY"
            let name = toYearFormatter.string(from: date!)
            calendarManager.currentYear = name
        }
        
        
    }
}

struct CalendarDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDisplayView(selectDate: Date(), isCallingFunc: .constant(false), calendarManager: CalendarManager())
    }
}
