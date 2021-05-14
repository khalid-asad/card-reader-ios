import XCTest
@testable import CardReader

final class CardReaderTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CardReader().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
