import XCTest

import Argon2Tests

var tests = [XCTestCaseEntry]()
tests += Argon2Tests.allTests()
XCTMain(tests)