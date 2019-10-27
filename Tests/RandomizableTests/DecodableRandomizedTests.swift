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

final class DecodableRandomizedTests: XCTestCase {
    func testRandomized() {
        struct Foo: Decodable {
            struct Inner: Decodable {
                let s: String?
                let i: Int?
                let a: [Double]?
                let ui8: UInt8
                let ui16: UInt16
                let ui32: UInt32
                let ui64: UInt64
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
                let i8: Int8
                let i16: Int16
                let i32: Int32
                let i64: Int64
            }
            let enumerated: Enum
            let date: Date
            let url: URL
            let nested: Inner
        }
        XCTAssertNoThrow(try Foo.randomized(encoding: { type, codingKeys in
            if codingKeys.last?.stringValue == "enumerated",
                let random = Foo.Enum.allCases.randomElement() {
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
