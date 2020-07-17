//
//  Ballot.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/10/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation

// MARK: - Ballot
struct Ballot: Encodable {
    internal init(voteBallot: String, hash: String) {
        self.voteBallot = voteBallot
        
    }
    
    let voteBallot:String
    let hash:String = "0"
}

let ballotOptions:[String] = ["Ballots are secret","Ballots visible to you","Ballots visible to everyone"]

