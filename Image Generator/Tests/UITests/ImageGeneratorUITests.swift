//
//  ImageGeneratorUITests.swift
//  ImageGeneratorUITests
//
//  Created by Evgeniy Goncharov on 22.05.2023.
//

import XCTest

final class ImageGeneratorUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTextFieldEnterTest() {
        let app = XCUIApplication()
        
        let textField = app.textFields["textField"]
        textField.tap()
        UIPasteboard.general.string = "Test"
        textField.doubleTap()
        app.menuItems.element(boundBy: 0).tap()
        
        if let text = textField.value as? String {
            XCTAssertEqual("Test", text)
        } else {
            XCTFail("Value isEmpty")
        }
    }
    
}
