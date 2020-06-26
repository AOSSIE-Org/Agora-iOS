//
//  Election.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/19/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseElection: Object{
    
    let id = UUID() // sys. gen. unique ID as we do not care of the actual value of it.
    @objc dynamic var _id:String = ""
    @objc dynamic var title:String = ""
    @objc dynamic var place:String = ""
    @objc dynamic var electionType:String = ""
    @objc dynamic var creatorName:String = ""
    @objc dynamic var creatorEmail:String = ""
    
    @objc dynamic var start = Date()
    @objc dynamic var end = Date()
    @objc dynamic var realtimeResult:Bool = false
    @objc dynamic var votingAlgo:String = ""
   
    @objc dynamic var ballotVisibility:String = ""
    @objc dynamic var voterListVisibility:Bool = false
    @objc dynamic var isInvite:Bool = false
    
    @objc dynamic var isCompleted:Bool = false
    @objc dynamic var isStarted:Bool = false
    @objc dynamic var createdTime:Date = Date()
    
    @objc dynamic var adminLink:String = ""
    @objc dynamic var inviteCode:String = ""
    

    
    @objc dynamic var numberRepeat:String = ""
    @objc dynamic var Reminder:String = ""
    @objc dynamic var eleColor:String = ""
    
    @objc dynamic var electionDescription:String = ""
    
    
    
    @objc dynamic var isAllDay:Bool = false
    @objc dynamic var timeZone:String = ""
    
   override static func primaryKey() -> String? {
       return "_id"
   }
    
}
