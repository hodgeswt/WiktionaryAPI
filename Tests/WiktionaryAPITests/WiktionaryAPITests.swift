import XCTest
@testable import WiktionaryAPI

final class WiktionaryAPITests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WiktionaryAPI().text, "Hello, World!")
    }
}
