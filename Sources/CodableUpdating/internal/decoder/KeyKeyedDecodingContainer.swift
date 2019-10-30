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
import Randomizable
import Idioms

struct KeyKeyedDecodingContainer<K : CodingKey>: KeyedDecodingContainerProtocol {
    typealias Key = K
    
    var store: KeyedStore<String>
    var values: KeyedStore<[String]>
    
    var codingPath: [CodingKey]
    
    var allKeys: [K] {
        []
    }
    
    init(codingPath: [CodingKey], store: KeyedStore<String>, values: KeyedStore<[String]>) {
        self.codingPath = codingPath
        self.store = store
        self.values = values
    }
    
    func contains(_ key: K) -> Bool {
        true
    }
    
    func decodeNil(forKey key: K) throws -> Bool {
        false
    }
    
    func decode(_ type: Bool.Type, forKey key: K) throws -> Bool {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: String.Type, forKey key: K) throws -> String {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Double.Type, forKey key: K) throws -> Double {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Float.Type, forKey key: K) throws -> Float {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int.Type, forKey key: K) throws -> Int {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int8.Type, forKey key: K) throws -> Int8 {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int16.Type, forKey key: K) throws -> Int16 {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int32.Type, forKey key: K) throws -> Int32 {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int64.Type, forKey key: K) throws -> Int64 {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt.Type, forKey key: K) throws -> UInt {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt8.Type, forKey key: K) throws -> UInt8 {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt16.Type, forKey key: K) throws -> UInt16 {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt32.Type, forKey key: K) throws -> UInt32 {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt64.Type, forKey key: K) throws -> UInt64 {
        let value = type.increment(in: store)
        values[codingPath.appending(key).map { $0.stringValue }] = value
        return value
    }
    
    func decode<T>(_ type: T.Type, forKey key: K) throws -> T where T : Decodable {
        if let type = type as? Incrementable.Type,
            let value = type.increment(in: store) as? T {
            values[codingPath.appending(key).map { $0.stringValue }] = value
            return value
        } else if let type = type as? Randomizable.Type,
            let value = type.randomized() as? T {
            values[codingPath.appending(key).map { $0.stringValue }] = value
            return value
        } else {
            let value = try type.init(from: KeyDecoder(codingPath: codingPath.appending(key), store: store, values: values))
            values[codingPath.appending(key).map { $0.stringValue }] = value
            return value
        }
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: K) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        KeyedDecodingContainer<NestedKey>(KeyKeyedDecodingContainer<NestedKey>(codingPath: codingPath.appending(key), store: store, values: values))
    }
    
    func nestedUnkeyedContainer(forKey key: K) throws -> UnkeyedDecodingContainer {
        KeyUnkeyedDecodingContainer(codingPath: codingPath.appending(key), store: store, values: values)
    }
    
    func superDecoder() throws -> Decoder {
        KeyDecoder(codingPath: codingPath, store: store, values: values)
    }
    
    func superDecoder(forKey key: K) throws -> Decoder {
        KeyDecoder(codingPath: codingPath.appending(key), store: store, values: values)
    }
}
