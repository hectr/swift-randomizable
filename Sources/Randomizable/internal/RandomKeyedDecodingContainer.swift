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

struct RandomKeyedDecodingContainer<K : CodingKey>: KeyedDecodingContainerProtocol {
    typealias Key = K

    var codingPath: [CodingKey] {
        []
    }

    var allKeys: [K] {
        []
    }

    private let customize: Decodable.Randomizing?

    init(customize: Decodable.Randomizing?) {
        self.customize = customize
    }

    func contains(_ key: K) -> Bool {
        true
    }

    func decodeNil(forKey key: K) throws -> Bool {
        false
    }

    func decode(_ type: Bool.Type, forKey key: K) throws -> Bool {
        (try customize?(type) as? Bool) ?? type.randomized()
    }

    func decode(_ type: String.Type, forKey key: K) throws -> String {
        (try customize?(type) as? String) ?? type.randomized()
    }

    func decode(_ type: Double.Type, forKey key: K) throws -> Double {
        (try customize?(type) as? Double) ?? type.randomized()
    }

    func decode(_ type: Float.Type, forKey key: K) throws -> Float {
        (try customize?(type) as? Float) ?? type.randomized()
    }

    func decode(_ type: Int.Type, forKey key: K) throws -> Int {
        (try customize?(type) as? Int) ?? type.randomized()
    }

    func decode(_ type: Int8.Type, forKey key: K) throws -> Int8 {
        (try customize?(type) as? Int8) ?? type.randomized()
    }

    func decode(_ type: Int16.Type, forKey key: K) throws -> Int16 {
        (try customize?(type) as? Int16) ?? type.randomized()
    }

    func decode(_ type: Int32.Type, forKey key: K) throws -> Int32 {
        (try customize?(type) as? Int32) ?? type.randomized()
    }

    func decode(_ type: Int64.Type, forKey key: K) throws -> Int64 {
        (try customize?(type) as? Int64) ?? type.randomized()
    }

    func decode(_ type: UInt.Type, forKey key: K) throws -> UInt {
        (try customize?(type) as? UInt) ?? type.randomized()
    }

    func decode(_ type: UInt8.Type, forKey key: K) throws -> UInt8 {
        (try customize?(type) as? UInt8) ?? type.randomized()
    }

    func decode(_ type: UInt16.Type, forKey key: K) throws -> UInt16 {
        (try customize?(type) as? UInt16) ?? type.randomized()
    }

    func decode(_ type: UInt32.Type, forKey key: K) throws -> UInt32 {
        (try customize?(type) as? UInt32) ?? type.randomized()
    }

    func decode(_ type: UInt64.Type, forKey key: K) throws -> UInt64 {
        (try customize?(type) as? UInt64) ?? type.randomized()
    }

    func decode<T>(_ type: T.Type, forKey key: K) throws -> T where T : Decodable {
        if let type = type as? Randomizable.Type,
            let value = (try customize?(type) as? T) ?? (type.randomized() as? T) {
            return value
        } else {
            return try (customize?(type) as? T) ?? type.init(from: RandomDecoder(customize: customize))
        }
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        KeyedDecodingContainer<NestedKey>(RandomKeyedDecodingContainer<NestedKey>(customize: customize))
    }

    func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
        RandomUnkeyedDecodingContainer(customize: customize)
    }

    func superDecoder() throws -> Decoder {
        RandomDecoder(customize: customize)
    }

    func superDecoder(forKey key: K) throws -> Decoder {
        RandomDecoder(customize: customize)
    }
}
