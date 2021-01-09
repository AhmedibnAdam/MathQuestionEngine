//
//  MathQuestionEngineTests.swift
//  MathQuestionEngineTests
//
//  Created by Adam on 07/01/2021.
//

import XCTest
@testable import MathQuestionEngine


class MathQuestionTest: XCTestCase {
    

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        //MARK: - Given

        var expectedResponse: Float!
        let exception = self.expectation(description: "Calculation wrong !")

        //MARK: - When
        let worker: ICalculationsWorker? = CalculationsWorker()
        let actual_responce = worker?.evaluateExpression(operators: ["+", "x"], operands: ["5","3","3"], time: 5)

            expectedResponse = actual_responce
            exception.fulfill()


        //MARK: - Then
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(expectedResponse)
        XCTAssertTrue(expectedResponse == 14)
//        XCTAssertEqual(expectedResponse , 5.0)
    }
    
}
