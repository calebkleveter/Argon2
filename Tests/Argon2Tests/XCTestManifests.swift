import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Argon2Tests.allTests),
    ]
}
#endif