//
//  agora_iosUITests.swift
//  agora-iosUITests
//
//  Created by Siddharth sen on 3/17/20.
//  Copyright © 2020 HalfPolygon. All rights reserved.
//

import XCTest

class agora_iosUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        

    }
    
    
      func test_invalid_login_with_username(){
           let app = XCUIApplication()
           app.launch()
        
        // Logout if already logged in
        if app.tabBars.buttons["Settings"].exists {
            app.tabBars.buttons["Settings"].tap()
            app.buttons["Logout"].tap()
            app.alerts["Log out?"].scrollViews.otherElements.buttons["Yes"].tap()
        }

           app.buttons["Login"].tap()
           let loginViewElementsQuery = app.scrollViews.otherElements.containing(.image, identifier:"login_tree")
           loginViewElementsQuery.children(matching: .textField).element.tap()
           let usernameField = loginViewElementsQuery.children(matching: .textField).element
           let passwordField = loginViewElementsQuery.children(matching: .secureTextField).element
           
           usernameField.doubleTap()
           sleep(1)
           usernameField.typeText("invalidUser\n")
           passwordField.doubleTap()
           sleep(1)
           passwordField.typeText("invalid\n")
           app.scrollViews.otherElements.buttons["Sign In"].tap()
    
        // Wait for existence of alert
        XCTAssertTrue(app.alerts["Incorrect username and / or password."].waitForExistence(timeout: 10))
       }

    func test_valid_login_with_username() {
        let app = XCUIApplication()
        app.launch()
        
        // Logout if already logged in
        if app.tabBars.buttons["Settings"].exists {
            app.tabBars.buttons["Settings"].tap()
            app.buttons["Logout"].tap()
            app.alerts["Log out?"].scrollViews.otherElements.buttons["Yes"].tap()
        }
        
        sleep(1)
        app.buttons["Login"].tap()
        
        let loginViewElementsQuery = app.scrollViews.otherElements.containing(.image, identifier:"login_tree")
        loginViewElementsQuery.children(matching: .textField).element.tap()
        let usernameField = loginViewElementsQuery.children(matching: .textField).element
        let passwordField = loginViewElementsQuery.children(matching: .secureTextField).element
        
        usernameField.doubleTap()
        
        sleep(1)
        app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.keys["g"].tap()
        app.keys["s"].tap()
        app.keys["o"].tap()
        app.keys["c"].tap()
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()

        passwordField.doubleTap()
        sleep(1)
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
       
        app.scrollViews.otherElements.buttons["Sign In"].tap()

        // Wait for existence of dashboard view
        XCTAssertTrue(app.staticTexts["Total Elections"].waitForExistence(timeout: 15))
        
        app.tabBars.buttons["Settings"].tap()
        app.buttons["Logout"].tap()
        // Wait for existence of alert
        XCTAssertTrue(app.alerts["Log out?"].waitForExistence(timeout: 15))
        

    }
    
 
    
    func test_logout_from_account(){
        let app = XCUIApplication()
        app.launch()
        
        // Logout if already logged in
        if app.tabBars.buttons["Settings"].exists {
            app.tabBars.buttons["Settings"].tap()
            app.buttons["Logout"].tap()
            app.alerts["Log out?"].scrollViews.otherElements.buttons["Yes"].tap()
           
        }
        
        sleep(1)
        app.buttons["Login"].tap()
        
        let loginViewElementsQuery = app.scrollViews.otherElements.containing(.image, identifier:"login_tree")
        loginViewElementsQuery.children(matching: .textField).element.tap()
        let usernameField = loginViewElementsQuery.children(matching: .textField).element
        let passwordField = loginViewElementsQuery.children(matching: .secureTextField).element
        
        usernameField.doubleTap()
        sleep(1)
        app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.keys["g"].tap()
        app.keys["s"].tap()
        app.keys["o"].tap()
        app.keys["c"].tap()
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()

        passwordField.doubleTap()
        sleep(1)
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()

        app.scrollViews.otherElements.buttons["Sign In"].tap()

        // Wait for existence of dashboard view
        XCTAssertTrue(app.staticTexts["Total Elections"].waitForExistence(timeout: 15))
        
        app.tabBars.buttons["Settings"].tap()
        app.buttons["Logout"].tap()
        // Wait for existence of alert
        XCTAssertTrue(app.alerts["Log out?"].waitForExistence(timeout: 15))
        app.alerts["Log out?"].scrollViews.otherElements.buttons["Yes"].tap()
        
    
        
        
    }
    
    func test_add_new_election_for_user(){
        
    }

    func test_launch_performance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
