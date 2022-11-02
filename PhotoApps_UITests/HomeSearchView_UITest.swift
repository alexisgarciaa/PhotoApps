//
//  HomeSearchView_UITest.swift
//  PhotoApps_UITests
//
//  Created by Alexis on 2/11/22.
//

import XCTest


final class HomeSearchView_UITest: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeSearchView_textField_shouldtapOnIt(){
        let textFiled = app.textFields["TextFieldSearchBar"]

        textFiled.tap()
        textFiled.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()


        let returnButton = app.buttons["Return"]
        returnButton.tap()
        XCTAssertTrue(textFiled.exists)
    }
    
    func test_HomeSearchView_CardView_navigateToDetailedImageView(){
        let textFiled = app.textFields["TextFieldSearchBar"]

        textFiled.tap()
        textFiled.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()


        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let cardView = app.otherElements.buttons["CardView"].firstMatch
        cardView.tap()
        
        XCTAssertTrue(app.staticTexts["DetailedImageView"].exists)
    }
    
    
    func test_HomeSearchView_CardView_navigateBacktosearchScreenfromDetailedView(){
        let textFiled = app.textFields["TextFieldSearchBar"]

        textFiled.tap()
        textFiled.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()


        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let cardView = app.otherElements.buttons["CardView"].firstMatch
        cardView.tap()
        
        let instructionViewExists = app.staticTexts["DetailedImageView"].exists
        
        
        let backButton = app.buttons["backToSearch"]
        
        backButton.tap()
        
        
        XCTAssertTrue(textFiled.exists)
        }
    
    func test_DetailedImageView_Openinbrowser_navigatetoBrowser(){
        let textFiled = app.textFields["TextFieldSearchBar"]

        textFiled.tap()
        textFiled.tap()
        
        let keyA = app.keys["A"]
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        keya.tap()


        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let cardView = app.otherElements.buttons["CardView"].firstMatch
        cardView.tap()
        
        let instructionViewExists = app.staticTexts["DetailedImageView"].exists
        
        
        let goToNavigator = app.otherElements.buttons["goToNavigator"].firstMatch
        
        goToNavigator.tap()
        
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        let isSafariBrowserOpen = safari.wait(for: .runningForeground, timeout: 30)
        XCTAssertTrue(isSafariBrowserOpen)
        
    }
    
    func test_HomeSearchView_ContactList_showAlert(){
        let BurgerMenuButton = app.otherElements.buttons["BurgerMenuButton"].firstMatch
        
        BurgerMenuButton.tap()
        BurgerMenuButton.tap()
        BurgerMenuButton.tap()
                
        
        let understandButonExist = app.staticTexts["understandButon"].exists
    
        XCTAssertTrue(understandButonExist)
        
        
        
    }
}

