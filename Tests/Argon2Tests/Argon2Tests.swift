import XCTest
@testable import Argon2

final class Argon2Tests: XCTestCase {
    func testHash()throws {
        _ = try XCTAssertNoThrow(Argon2.hash("password"))
        try XCTAssertNotEqual(Argon2.hash("password"), "")
    }
    
    func testVerify()throws {
        let hash = try Argon2.hash("password")
        
        try XCTAssertNoThrow(Argon2.verify("password", against: hash))
    }
    
    func testHashBenchmark()throws {
        measure {
            do {
                _ = try Argon2.hash([112, 97, 115, 115, 119, 111, 114, 100])
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    static var allTests: [(String, (Argon2Tests) -> ()throws -> ())] = [
        ("testHash", testHash),
        ("testVerify", testVerify),
        ("testHashBenchmark", testHashBenchmark)
    ]
}
