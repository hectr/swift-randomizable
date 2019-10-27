import XCTest

import CodableUpdatingTests
import RandomizableTests

var tests = [XCTestCaseEntry]()
tests += CodableUpdatingTests.__allTests()
tests += RandomizableTests.__allTests()

XCTMain(tests)
