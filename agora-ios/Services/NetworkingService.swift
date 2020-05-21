//
//  NetworkingService.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/29/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

 
import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class NetworkingService:ObservableObject{
    var header:HTTPHeaders
    
    init(userXAUTH:String) {
       header = [
            //AUTH Key
            "X-Auth-Token": "\(userXAUTH)"]
    }
    
    //MARK:- Authentication
    
    func userLogin(){
        
    }
    
    func userSignup(){
        
    }
    
    func userResetSend(){
        
    }
    func userResetValidate(){
        
    }
    
    
    //MARK:- Election
    func storeElection(){
        
    }
    
    func printDatabase(){
        
    }
    
    func fetchElectionData(ID:String){
        
        AF.request("https://agora-rest-api.herokuapp.com/api/v1/election/\(ID)",
            method: .get,
            headers: header).responseJSON { response in
                if (response.error == nil){
                    print("Got data for Election\(ID)")
                    if let electionDataResponse = response.value{
                        let electionJSON: JSON = JSON(electionDataResponse)
                        
                        let config = Realm.Configuration(schemaVersion : 2)
                        do{
                            let realm = try Realm(configuration: config)
                            let newdata = Election()
                            newdata.title = electionJSON["name"].stringValue
                            newdata.place = electionJSON["description"].stringValue
//                            newdata.isAllDay = electionJSON["electionType"].stringValue
//
//                            newdata.start = toDate(electionJSON["start"].stringValue)
//                            newdata.end = toDate(electionJSON["end"].stringValue)
//                            newdata.timeZone = extractTimeZone(electionJSON["createdTime"].stringValue)
//                            newdata.votingAlgo = electionJSON["votingAlgo"].stringValue

                            newdata.eleColor = "Blue"
                            newdata.electionDescription = electionJSON["description"].stringValue
                            newdata.candidates = electionJSON["candidates"].stringValue
                            try realm.write({
                                realm.add(newdata)
                                print("Election details added successfully")
                            })
                            
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }else{
                    print(response.error)
                }
        }
    }
}
