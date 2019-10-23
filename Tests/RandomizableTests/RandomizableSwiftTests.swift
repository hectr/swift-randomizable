// Copyright (c) 2019 Hèctor Marquès Ranea
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import XCTest
import Randomizable

final class RandomizableSwiftTests: XCTestCase {
    private struct Foo: Codable, Equatable, Hashable {
        let foo: Int
    }

    private enum Enum: String, Codable {
        case none
    }

    func testArrayOfCodablesCanBeEmpty() {
        XCTAssertTrue([Enum].randomized().isEmpty)
    }

    func testArrayOfCodablesCanBeNonEmpty() {
        var done = false
        for _ in 0...100 {
            if ![Foo].randomized().isEmpty {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testArrayOfCodablesChanges() {
        var done = false
        let base = [Foo].randomized()
        for _ in 0...100 {
            if [Foo].randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testArrayCanBeNonEmpty() {
        var done = false
        for _ in 0...100 {
            if ![Int].randomized().isEmpty {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testArrayChanges() {
        var done = false
        let base = [String].randomized()
        for _ in 0...100 {
            if [String].randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testBoolCanBeTrue() {
        var done = false
        for _ in 0...100 {
            if Bool.randomized() {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testBoolCanBeFalse() {
        var done = false
        for _ in 0...100 {
            if !Bool.randomized() {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testDictionaryWithCodablesCanBeEmpty() {
        XCTAssertTrue([String: Enum].randomized().isEmpty)
    }

    func testDictionaryWithCodablesCanBeNonEmpty() {
        var done = false
        for _ in 0...100 {
            if ![String: Foo].randomized().isEmpty {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testDictionaryWithCodablesChanges() {
        var done = false
        let base = [Foo: UInt].randomized()
        for _ in 0...100 {
            if [Foo: UInt].randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testDictionaryCanBeNonEmpty() {
        var done = false
        for _ in 0...100 {
            if ![String: Int].randomized().isEmpty {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testDictionaryChanges() {
        var done = false
        let base = [String: String].randomized()
        for _ in 0...100 {
            if [String: String].randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testDoubleCanBePositive() {
        var done = false
        for _ in 0...100 {
            if Double.randomized() > 0 {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testDoubleCanBeNegative() {
        var done = false
        for _ in 0...100 {
            if Double.randomized() < 0 {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testDoubleChanges() {
        var done = false
        let base = Double.randomized()
        for _ in 0...100 {
            if Double.randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testFloatCanBePositive() {
        var done = false
        for _ in 0...100 {
            if Float.randomized() > 0 {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testFloatCanBeNegative() {
        var done = false
        for _ in 0...100 {
            if Float.randomized() < 0 {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testFloatChanges() {
        var done = false
        let base = Float.randomized()
        for _ in 0...100 {
            if Float.randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testIntCanBePositive() {
        var done = false
        for _ in 0...100 {
            if Float.randomized() > 0 {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testIntCanBeNegative() {
        var done = false
        for _ in 0...100 {
            if Float.randomized() < 0 {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testIntChanges() {
        var done = false
        let base = Int.randomized()
        for _ in 0...100 {
            if Int.randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testUIntCanBeNonZero() {
        var done = false
        for _ in 0...100 {
            if UInt.randomized() != 0 {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testUIntChanges() {
        var done = false
        let base = UInt.randomized()
        for _ in 0...100 {
            if UInt.randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testOptionalCanBeNonNil() {
        var done = false
        for _ in 0...100 {
            if Int?.randomized() != nil {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testOptionalChanges() {
        var done = false
        let base = UInt?.randomized()
        for _ in 0...100 {
            if UInt?.randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testStringCanBeNonEmpty() {
        var done = false
        for _ in 0...100 {
            if !String.randomized().isEmpty {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    func testStringChanges() {
        var done = false
        let base = String.randomized()
        for _ in 0...100 {
            if String.randomized() != base {
                done = true
                break
            }
        }
        XCTAssertTrue(done)
    }

    static var allTests = [
        ("testArrayOfCodablesCanBeEmpty", testArrayOfCodablesCanBeEmpty),
        ("testArrayOfCodablesCanBeNonEmpty", testArrayOfCodablesCanBeNonEmpty),
        ("testArrayOfCodablesChanges", testArrayOfCodablesChanges),
        ("testArrayCanBeNonEmpty", testArrayCanBeNonEmpty),
        ("testArrayChanges", testArrayChanges),
        ("testBoolCanBeTrue", testBoolCanBeTrue),
        ("testBoolCanBeFalse", testBoolCanBeFalse),
        ("testDictionaryWithCodablesCanBeEmpty", testDictionaryWithCodablesCanBeEmpty),
        ("testDictionaryWithCodablesCanBeNonEmpty", testDictionaryWithCodablesCanBeNonEmpty),
        ("testDictionaryWithCodablesChanges", testDictionaryWithCodablesChanges),
        ("testDictionaryCanBeNonEmpty", testDictionaryCanBeNonEmpty),
        ("testDictionaryChanges", testDictionaryChanges),
        ("testDoubleCanBePositive", testDoubleCanBePositive),
        ("testDoubleCanBeNegative", testDoubleCanBeNegative),
        ("testDoubleChanges", testDoubleChanges),
        ("testFloatCanBePositive", testFloatCanBePositive),
        ("testFloatCanBeNegative", testFloatCanBeNegative),
        ("testFloatChanges", testFloatChanges),
        ("testIntCanBePositive", testIntCanBePositive),
        ("testIntCanBeNegative", testIntCanBeNegative),
        ("testIntChanges", testIntChanges),
        ("testUIntCanBeNonZero", testUIntCanBeNonZero),
        ("testUIntChanges", testUIntChanges),
        ("testOptionalCanBeNonNil", testOptionalCanBeNonNil),
        ("testOptionalChanges", testOptionalChanges),
        ("testStringCanBeNonEmpty", testStringCanBeNonEmpty),
        ("testStringChanges", testStringChanges),
    ]
}
