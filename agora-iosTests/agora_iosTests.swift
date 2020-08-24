//
//  agora_iosTests.swift
//  agora-iosTests
//
//  Created by Siddharth sen on 3/17/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import XCTest
@testable import agora_ios

var apiService: APIService!


class agora_iosTests: XCTestCase {

    override func setUp() {
        // This method is called before the invocation of each test method in the class.
        apiService = APIService()
        apiService.apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxLTcwSGdPMTdWS3BFME5nZWNNNmNQdWU4SjdoNzFNT2ZURGZtaU5NUUtQY2JrWlhESU40Y3M4SkxyMEZDM1dWcjhmcXNVOEtjNDNHeDdMU1NvMTRzTG9GK2hqbThPIiwiaXNzIjoicGxheS1zaWxob3VldHRlIiwiZXhwIjoxNTk4MjkwNjU3LCJpYXQiOjE1OTgyNDc0NTcsImp0aSI6ImE1MzczZWQ1NDRiN2ZkMTM4OGY5OGIwZmIzYzUwZGU5NDFkYjk0NzIyNWYxZmQwM2VlZDcxOGEyODEwYTE2ZjQwMmJmOGVmNGIxODk5ODZiMGRmOTA5NmUzNDA5NzI1NTU3MGI5MGVjOGRkNzM1MGRlMzZjYzY2NDg1MDczYzI1ZDViNjU5NGE4MjFlNTA0MGMzMTE3NzdiNTNlNTMzMTY2MDBjODkwMjg2YTVmNDU3ZWU4YjM0ZTBhOTNjY2RlNjc1NTUwNGQzMDc3NDM1Y2IxZWM3OWE0MTRkNmU2ZjhkNDM1OGRkZjY3ZmI3NDNhNTQ4ZTYzYTQ2MTY3YTZhZjIifQ.hOyG4I3dYUqaAfBRZVyFw-jW5eDF46dX7eisfpve0D8"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_signin_with_expectedApiKey_and_path() {
        apiService.userLogin(username: "gsoctest", password: "test", endpoint: .login, onFailure: {
            XCTAssert(false)
        }) {
            XCTAssert(true)
        }
    }
    
    func test_signup_with_expectedApiKey_and_path() {
        
        apiService.userSignup(username: "test", password: "test", email: "test@xyz.com", firstName: "Main", lastName: "signup", question: "", questionAnswer: "", endpoint: .signup, onFailure: {
            XCTAssert(false)
        }) {
            XCTAssert(true)
        }
    }
    
    func test_get_election() {
        
        apiService.getElection(endpoint: .electionGetAll, ID: "", userXAuth: apiService.apiKey!) {
            XCTAssert(true)
        }
        
    }
    
    func test_create_new_election() {
        
        apiService.createNewElection(for: Election(name: "", description: "", electionType: "", candidates: [], ballotVisibility: "", voterListVisibility: true, isInvite: false, startingDate: Date(), endingDate: Date(timeInterval: TimeInterval(exactly: 200)! , since: Date()), isRealTime: true, votingAlgo: "", noVacancies: 1, ballot: []), userXAuth: apiService.apiKey!) {
            XCTAssert(true)
        }
        
    }
    
    



}
