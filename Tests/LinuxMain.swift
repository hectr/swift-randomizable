import XCTest

import RandomizableTests

var tests = [XCTestCaseEntry]()
tests += RandomizableTests.__allTests()

XCTMain(tests)
