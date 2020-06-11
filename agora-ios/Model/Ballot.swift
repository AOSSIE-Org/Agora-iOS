//
//  Ballot.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/10/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation

// MARK: - Ballot
class Ballot:NSObject {
    internal init(voteBallot: String, _hash: String) {
        self.voteBallot = voteBallot
        self._hash = _hash
    }
    
    let voteBallot:String
    let _hash:String
}
