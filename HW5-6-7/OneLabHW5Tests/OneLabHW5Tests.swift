//
//  OneLabHW5Tests.swift
//  OneLabHW5Tests
//
//  Created by Mereke on 18.04.2023.
//

@testable import OneLabHW5
import XCTest

final class OneLabHW5Tests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Add any setup code here.
    }

    override func tearDownWithError() throws {
        // Add any teardown code here.
        try super.tearDownWithError()
    }

    func testSaveToken() {
        let token = "test_token"
        XCTAssertTrue(KeychainHelper.saveToken(token))
    }

    func testGetToken() {
        let token = "test_token"
        XCTAssertTrue(KeychainHelper.saveToken(token))

        let retrievedToken = KeychainHelper.getToken()
        XCTAssertEqual(retrievedToken, token)
    }

    func testDeleteToken() {
        let token = "test_token"
        XCTAssertTrue(KeychainHelper.saveToken(token))

        XCTAssertTrue(KeychainHelper.deleteToken())
        XCTAssertNil(KeychainHelper.getToken())
    }

    func testPerformanceExample() throws {
        let token = "test_token"
        measure {
            XCTAssertTrue(KeychainHelper.saveToken(token))
            XCTAssertNotNil(KeychainHelper.getToken())
            XCTAssertTrue(KeychainHelper.deleteToken())
        }
    }
}


