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

final class CodableRandomizedTests: XCTestCase {
    func testRandomized() {
        struct Foo: Codable {
            struct Inner: Codable {
                let s: String?
                let i: Int?
                let a: [Double]?
            }
            let bool: Bool
            let unsignedInteger: UInt
            let integer: Int
            let float: Float
            let double: Double
            let string: String
            let array: [String]
            let nested: Inner
        }
        XCTAssertNoThrow(try Foo.randomized())
    }

    func testRandomizedWithCustomEncoding() {
        struct Foo: Codable {
            enum Enum: String, CaseIterable, Codable {
                case a
                case b
                case c
            }
            struct Inner: Codable {
                let zero: Int
                let integer: Int
            }
            let enumerated: Enum
            let date: Date
            let url: URL
            let nested: Inner
        }
        XCTAssertNoThrow(try Foo.randomized(encoding: { type, codingKeys in
            if codingKeys.first?.stringValue == "enumerated",
                let random = Foo.Enum.allCases.randomElement() {
                return try JSONEncoder().encode(random)
            } else if codingKeys.first?.stringValue == "date" {
                let random = Date.randomized()
                return try JSONEncoder().encode(random)
            } else if codingKeys.first?.stringValue == "url" {
                let random = URL.randomized()
                return try JSONEncoder().encode(random)
            } else if codingKeys.last?.stringValue == "zero" {
                let zero = 0
                return try JSONEncoder().encode(zero)
            }
            return nil
        }))
    }

    static var allTests = [
        ("testRandomized", testRandomized),
        ("testRandomizedWithCustomEncoding", testRandomizedWithCustomEncoding),
    ]
}
