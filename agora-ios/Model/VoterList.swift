//
//  VoterList.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/10/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation

class VoterList:NSObject{
    internal init(name: String, _hash: String) {
        self.name = name
        self._hash = _hash
    }
    
    let name: String
    let _hash: String
}
