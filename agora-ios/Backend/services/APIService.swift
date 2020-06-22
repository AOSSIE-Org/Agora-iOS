//
//  APIService.swift
//  agora-ios
//
//  Created by Siddharth sen on 3/29/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class APIService{
    var header:HTTPHeaders = ["X-Auth-Token": ""]
    let baseURL = URL(string:"https://agora-rest-api.herokuapp.com")
    var apiKey:String?

    
    init(userXAUTH:String) {
        header = [
            //AUTH Key
            "X-Auth-Token": "\(userXAUTH)"]
    }
    
    public enum APIError:Error{
        case noResponse
        case jsonDecodingError(error:Error)
        case networkError(error:Error)
    }
    
    public enum EndPoint{
        // Authentication
        case authenticate(provider:String)
        case login
        case forgotPasswordSend(userName:String)
        case forgotPasswordReset(token:String)
        case signup
        // Election
        case electionBallots(id:String)
        case electionAddVoter(id:String)
        case electionVoters(id:String)
        case electionAddListOfVoters(id:String)
        case electionGetAll
        case electionCreate
        case electionGetDataWithID(id:String)
        case electionEditWithID(id:String)
        case electionDeleteWithID(id:String)
        case electionPollVoterLink(id:String)
        // Result
        case resultGetWithID(id:String)
        // Two Factor
        case securityQuestionGet(crypto:String)
        case verifyOTP
        case resendOTP(userName:String)
        case toggleTwoFactor
        case verifySecurityQuestion
        // Verification
        case resendActivationLink(userName:String)
        case activateAccount(token:String)
        // Vote
        case castVote(id:String)
        case verifyPrivateElectionVotersLink(id:String,pass:String)
        case verifyPublicElectionVotersLink(id:String)
        // User
        case userUpdate
        case userGet
        case userChangePassword
        case userChangeAvatar
        case userLogout
        
        
        
        func path() -> String {
            switch self {
            case .login:
                return "/api/v1/auth/login"
            case let .authenticate(provider):
                return "/api/v1/auth/authenticate/\(provider)"
            case .forgotPasswordSend(userName: let userName):
                return "/api/v1/auth/forgotPassword/send/\(userName)"
            case .forgotPasswordReset(token: let token):
                return "/api/v1/auth/forgotPassword/reset/\(token)"
            case .signup:
                return "/api/v1/auth/signup"
            case .electionBallots(id: let id):
                return "/api/v1/election/\(id)/ballots"
            case .electionAddVoter(id: let id):
                return "/api/v1/election/\(id)/voter"
            case .electionVoters(id: let id):
                return "/api/v1/election/\(id)/voters"
            case .electionAddListOfVoters(id: let id):
                return "/api/v1/election/\(id)/voters"
            case .electionGetAll:
                return "/api/v1/election"
            case .electionCreate:
                return "/api/v1/election"
            case .electionGetDataWithID(id: let id):
                return "/api/v1/election/\(id)"
            case .electionEditWithID(id: let id):
                return "/api/v1/election/\(id)"
            case .electionDeleteWithID(id: let id):
                return "/api/v1/election/\(id)"
            case .electionPollVoterLink(id: let id):
                return "/api/v1/election/\(id)/pollVoterLink"
            case .resultGetWithID(id: let id):
                return "/api/v1/result/\(id)"
            case .securityQuestionGet(crypto: let crypto):
                return "/api/v1/securityQuestion/\(crypto)"
            case .verifyOTP:
                return "/api/v1/verifyOtp"
            case .resendOTP(userName: let userName):
                return "/api/v1/resendOtp/\(userName)"
            case .toggleTwoFactor:
                return "/api/v1/toggleTwoFactorAuth"
            case .verifySecurityQuestion:
                return "/api/v1/verifySecurityQuestion"
            case .resendActivationLink(userName: let userName):
                return "/api/v1/account/email/\(userName)"
            case .activateAccount(token: let token):
                return "/api/v1/account/activate/\(token)"
            case .castVote(id: let id):
                return "/api/v1/vote/\(id)"
            case .verifyPrivateElectionVotersLink(id:let id,pass: let pass):
                return "/api/v1/voter/verify/\(id)/\(pass)"
            case .verifyPublicElectionVotersLink(id: let id):
                return "/api/v1/voter/verifyPoll/\(id)"
            case .userUpdate:
                return "/api/v1/user/update"
            case .userGet:
                return "/api/v1/user"
            case .userChangePassword:
                return "api/v1/user/changePassword"
            case .userChangeAvatar:
                return "/api/v1/user/changeAvatar"
            case .userLogout:
                return "/api/v1/user/logout"
                
            }
        }
        
    }
    
    
    
    public func getElection(endpoint: EndPoint,ID:String, completion: @escaping ()->Void) -> Void{
        let queryURL = baseURL!.appendingPathComponent(endpoint.path())
        AF.request(queryURL,
                   method: .get,
                   headers: header).responseData { response in
                    guard let data = response.data else { return }
                    let json = try? JSON(data:data)
                    
                     
                    if json!["elections"].arrayValue.isEmpty{
                        print("No Elections")
                        completion()
                        return
                    }
                    
                    for i in json!["elections"]{
                        
                        print("Got data for Election: \(i.1["_id"])")
                        
                        // Put in db
                        let config = Realm.Configuration(schemaVersion : 4)
                        do{
                            let realm = try Realm(configuration: config)
                            let databaseElection = DatabaseElection()
                            databaseElection._id = i.1["_id"].stringValue
                            databaseElection.title = i.1["name"].stringValue
                            databaseElection.place = i.1["description"].stringValue
                            databaseElection.electionType = i.1["electionType"].stringValue
                            databaseElection.creatorName = i.1["creatorName"].stringValue
                            databaseElection.creatorEmail = i.1["creatorEmail"].stringValue
                            
                            databaseElection.start = i.1["start"].dateValue!
                            
                            databaseElection.end = i.1["end"].dateValue!
                            
                            
                            databaseElection.realtimeResult = i.1["realtimeResult"].boolValue
                            databaseElection.votingAlgo = i.1["votingAlgo"].stringValue
                            //databaseElection.candidates = i.1["candidates"].arrayValue.map{$0.stringValue}
                            databaseElection.ballotVisibility = i.1["ballotVisibility"].stringValue
                            databaseElection.voterListVisibility = i.1["voterListVisibility"].boolValue
                            databaseElection.isInvite = i.1["isInvite"].boolValue
                            
                            databaseElection.isCompleted = i.1["isCompleted"].boolValue
                            databaseElection.isStarted = i.1["isStarted"].boolValue
                            // databaseElection.createdTime = i.1["createdTime"].dateValue!
                            
                            databaseElection.adminLink = i.1["adminLink"].stringValue
                            databaseElection.inviteCode = i.1["inviteCode"].stringValue
                            
                            //                    for ballot in i.1["ballot"].arrayValue {
                            //                        let newB = Ballot(voteBallot: ballot["voteBallot"].stringValue, _hash: ballot["hash"].stringValue)
                            //                        databaseElection.ballot.append(newB)
                            //                    }
                            
                            //                    for voter in i.1["voterList"].arrayValue{
                            //                        let newVoter = VoterList(name: voter["name"].stringValue, _hash: voter["hash"].stringValue)
                            //                        databaseElection.voterList.append(newVoter)
                            //                    }
                            
                            
                            
                            
                            databaseElection.eleColor = ["Blue","Red","Pink"].randomElement()!
                            
                            try realm.write({
                                realm.add(databaseElection,update: .modified)
                                print("Election details added successfully")
                                
                               completion()
                            })
                            
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
        }
    }
    
    
    
    //MARK:- Authentication
    
    public func userLogin(username:String,password:String,endpoint:EndPoint,onFailure: @escaping ()->Void, onSuccess: @escaping ()->Void
    ){
        let queryURL = baseURL!.appendingPathComponent(endpoint.path())
        let parameters: Parameters = [ "identifier" : username, "password" : password,"trustedDevice":"iOS" ]
       
        
        AF.request(queryURL,
                   method: .post,parameters: parameters,encoding: JSONEncoding.default,headers: nil).responseData { response in
                    guard let data = response.data else {
                        print("Login Failed!")
                        
                        onFailure()
                        return
                        
                    }
                    let json = try? JSON(data:data)
                    print("Login Successful!")
                    
                    
                    self.writeToDatabase(json: json){
                        
                        UserDefaults.standard.set(Credentials.token, forKey: "userXAUTH")
                        // Success
                        onSuccess()
                    }
        }
        
    }
    
    private func writeToDatabase(json:JSON?,complete:()->Void){
        // Set Realm User
        let userConfig = Realm.Configuration(schemaVersion : 4)
         
         do{
             let realm = try Realm(configuration: userConfig)
             
             let databaseUser = DatabaseUser()
             // Set values
             databaseUser.username = json!["username"].stringValue
             databaseUser.email = json!["email"].stringValue
             databaseUser.firstName = json!["firstName"].stringValue
             databaseUser.lastName = json!["lastName"].stringValue
             databaseUser.avatarURL = json!["avatarURL"].stringValue
             databaseUser.twoFactorAuthentication = json!["twoFactorAuthentication"].boolValue
             databaseUser.token = json!["token"]["token"].stringValue
             //databaseUser.expiresOn = json!["token"]["expiresOn"].dateValue!
             databaseUser.trustedDevice = json!["trustedDevice"].stringValue
             
             try realm.write({
                 realm.add(databaseUser,update: .modified)
                 print("User info. added successfully")
             })
             
             
         }catch{
             print(error.localizedDescription)
         }
         // Set values
         Credentials.username = json!["username"].stringValue
         Credentials.email = json!["email"].stringValue
         Credentials.firstName = json!["firstName"].stringValue
         Credentials.lastName = json!["lastName"].stringValue
         Credentials.avatarURL = json!["avatarURL"].stringValue
         Credentials.twoFactorAuthentication = json!["twoFactorAuthentication"].boolValue
         Credentials.token = json!["token"]["token"].stringValue
         //Credentials.expiresOn = json!["token"]["expiresOn"].dateValue!
         Credentials.trustedDevice = json!["trustedDevice"].stringValue
        
        complete()
      
    }
    
    public func userLoginSocial(endpoint:EndPoint, completion:@escaping ()->Void){
        
         let queryURL = baseURL!.appendingPathComponent(endpoint.path())
        // Get from UserDefaults
         let fbAccessToken = UserDefaults.standard.string(forKey: "fbAccessToken")
        
        
        
        AF.request(queryURL,method: .get ,headers: ["Access-Token":fbAccessToken!]).responseData{ response in
            guard let data = response.data
                else {
                print("Failed to get access userXAUTH")
                return }
            
            let json = try? JSON(data:data)
            
            print("Got userXAUTH Successfully!")
                let token = json!["token"].stringValue
                       Credentials.token = token
            
            self.header = ["X-Auth-Token":token]
            
                       UserDefaults.standard.set(json!["token"].stringValue, forKey: "userXAUTH")
            completion()
 
        }
        
    }
    
    public func getUserInfo(completion:@escaping ()->Void){
        let queryURL = baseURL!.appendingPathComponent(EndPoint.userGet.path())
        
        AF.request(queryURL,method: .get,headers: header ).responseData{
            response in
            guard let data = response.data else {
                print("Failed to get User Info.")
                return
            }
            
            let json = try? JSON(data:data)
            self.writeToDatabase(json: json) {
               // self.getElection(endpoint: .electionGetAll, ID: "")
                print("email:\(Credentials.email)")
                completion()
            }
            
        }
    }
    
}
