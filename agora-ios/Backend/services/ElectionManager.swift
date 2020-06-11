//
//  ElectionManager.swift
//  agora-ios
//
//  Created by Siddharth sen on 6/11/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import Foundation
import SwiftUI


class ElectionManager:ObservableObject{
    
    static var apiService = APIService(userXAUTH: Credentials.token)
    
    
   
    static func getAllElections(complete: () -> Void) -> Void {
        ElectionManager.apiService.getElection(endpoint: .electionGetAll, ID: "")
        complete()
    }
    
    
    
}
