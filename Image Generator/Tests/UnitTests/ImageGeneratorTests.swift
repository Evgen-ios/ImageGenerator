//
//  ImageGeneratorTests.swift
//  ImageGeneratorTests
//
//  Created by Evgeniy Goncharov on 22.05.2023.
//

import XCTest

final class ImageGeneratorTests: XCTestCase {
    
    var sut: URLSession!
    
    func testGetsHTTPStatusCode200() throws {
        let urlString = "https://dummyimage.com/500x500&text=test"
        let url = URL(string: urlString)!
        let promise = expectation(description: "200")
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail(statusCode.description)
                }
            }
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 10)
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
}
