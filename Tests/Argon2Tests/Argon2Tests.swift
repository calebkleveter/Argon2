import XCTest
@testable import Argon2

final class Argon2Tests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Argon2().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
