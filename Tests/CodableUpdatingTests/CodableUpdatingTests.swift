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
import CodableUpdating
import Randomizable

final class CodableUpdatingTests: XCTestCase {
    func test() throws {
        struct Foo: Codable, Equatable {
            enum Enum: String, CaseIterable, Codable, Equatable, Randomizable {
                case a
                case b
                case c
            }
            struct Inner: Codable, Equatable {
                let i: Int
                let i8: Int8
                var i16: Int16
                let i32: Int32
                let i64: Int64
                let e: Enum
            }
            let float: Float
            var double: Double?
            let date: Date
            let url: URL
            let nested: Inner
        }
        let foo = try Foo.randomized()

        let newFloat = Float(0.3)
        let newDouble: Double? = nil
        let newDate = Date(timeIntervalSince1970: 0)
        let newUrl = URL(string: "www.example.org")!
        let newNested = Foo.Inner(i: 0, i8: 1, i16: 2, i32: 3, i64: 4, e: .a)
        let newEnum = Foo.Enum.b
        let newI = -19

        let newFoo = foo
            .updating(\.float, to: newFloat)
            .updating(\.double, to: newDouble)
            .updating(\.date, to: newDate)
            .updating(\.url, to: newUrl)
            .updating(\.nested, to: newNested.updating(\.e, to: newEnum))
            .updating(\.nested.i, to: newI)

        XCTAssertEqual(newFoo.float, newFloat)
        XCTAssertEqual(newFoo.double, newDouble)
        XCTAssertEqual(newFoo.date, newDate)
        XCTAssertEqual(newFoo.url, newUrl)
        XCTAssertEqual(newFoo.nested.e, newEnum)
        XCTAssertEqual(newFoo.nested.i, newI)
    }

    static var allTests = [
        ("test", test),
    ]
}
