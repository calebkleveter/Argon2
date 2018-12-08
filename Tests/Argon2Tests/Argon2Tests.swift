import XCTest
@testable import Argon2

final class Argon2Tests: XCTestCase {
    func testHash()throws {
        _ = try XCTAssertNoThrow(Argon2.hash("password"))
    }
    
    func testVerify()throws {
        let hash = try Argon2.hash("password")
        
        try XCTAssertNoThrow(Argon2.verify("password", against: hash))
    }
    
    static var allTests: [(String, (Argon2Tests) -> ()throws -> ())] = [
        ("testHash", testHash),
        ("testVerify", testVerify)
    ]
}
