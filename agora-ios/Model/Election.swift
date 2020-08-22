//
//  Election.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/27/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Election: Encodable{

     let name:String
     let description:String
     let electionType:String
     let candidates:[String]
     let ballotVisibility:String
     let voterListVisibility:Bool
     let isInvite:Bool
     let startingDate:Date
     let endingDate:Date
     let isRealTime:Bool
     let votingAlgo:String
     let noVacancies:Int
     let ballot:[Ballot]
    
    
    
    func toJSON() -> JSON {
        return [
            "name": name as Any,
            "description": description as Any,
            "electionType": electionType as Any,
            "candidates": candidates as Any,
            "ballotVisibility": ballotVisibility as Any,
            "voterListVisibility": voterListVisibility as Any,
            "startingDate": startingDate.asString() as Any,
            "endingDate": endingDate.asString() as Any,
            "isInvite": isInvite as Any,
            "isRealTime": isRealTime as Any,
            "votingAlgo": votingAlgo as Any,
            "noVacancies": noVacancies as Any,
            "ballot":ballot as Any
        ]
    }

}

