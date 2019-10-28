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

import Foundation

struct RandomUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    var codingPath: [CodingKey] {
        []
    }

    var count: Int? {
        0
    }

    var currentIndex: Int {
        0
    }

    var isAtEnd: Bool {
        true
    }

    private let customize: Decodable.Randomizing?

    init(customize: Decodable.Randomizing?) {
        self.customize = customize
    }

    mutating func decodeNil() throws -> Bool {
        false
    }

    mutating func decode(_ type: Bool.Type) throws -> Bool {
        (try customize?(type) as? Bool) ?? type.randomized()
    }

    mutating func decode(_ type: String.Type) throws -> String {
        (try customize?(type) as? String) ?? type.randomized()
    }

    mutating func decode(_ type: Double.Type) throws -> Double {
        (try customize?(type) as? Double) ?? type.randomized()
    }

    mutating func decode(_ type: Float.Type) throws -> Float {
        (try customize?(type) as? Float) ?? type.randomized()
    }

    mutating func decode(_ type: Int.Type) throws -> Int {
        (try customize?(type) as? Int) ?? type.randomized()
    }

    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        (try customize?(type) as? Int8) ?? type.randomized()
    }

    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        (try customize?(type) as? Int16) ?? type.randomized()
    }

    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        (try customize?(type) as? Int32) ?? type.randomized()
    }

    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        (try customize?(type) as? Int64) ?? type.randomized()
    }

    mutating func decode(_ type: UInt.Type) throws -> UInt {
        (try customize?(type) as? UInt) ?? type.randomized()
    }

    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        (try customize?(type) as? UInt8) ?? type.randomized()
    }

    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        (try customize?(type) as? UInt16) ?? type.randomized()
    }

    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        (try customize?(type) as? UInt32) ?? type.randomized()
    }

    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        (try customize?(type) as? UInt64) ?? type.randomized()
    }

    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        if let type = type as? Randomizable.Type,
            let value = (try customize?(type) as? T) ?? (type.randomized() as? T) {
            return value
        } else {
            return try (customize?(type) as? T) ?? type.init(from: RandomDecoder(customize: customize))
        }
    }

    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        KeyedDecodingContainer<NestedKey>(RandomKeyedDecodingContainer<NestedKey>(customize: customize))
    }

    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        RandomUnkeyedDecodingContainer(customize: customize)
    }

    mutating func superDecoder() throws -> Decoder {
        RandomDecoder(customize: customize)
    }
}
