import XCTest
@testable import CRCCalculator

final class CRCCalculatorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CRCCalculator().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
