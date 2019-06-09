import XCTest
@testable import CRCCalculator

final class CRCCalculatorTests: XCTestCase {
    
    func testCRCArc() {
        let aswer: UInt16 = 0xF82E
        let str = "test"
        let data = Data(str.utf8)
        let bytes = [UInt8](data)
        
        let calculator = CRCCalc()
        let bytesCalculated = calculator.calculate(type: .ARC, bytes: bytes)
        
        XCTAssertEqual(aswer, bytesCalculated)
    }

    static var allTests = [
        ("testCRCArc", testCRCArc),
    ]
}
