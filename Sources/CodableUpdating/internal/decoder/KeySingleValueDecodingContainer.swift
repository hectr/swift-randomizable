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

struct KeySingleValueDecodingContainer: SingleValueDecodingContainer {
    var store: KeyedStore<String>
    var values: KeyedStore<[String]>
    
    var codingPath: [CodingKey]
    
    init(codingPath: [CodingKey], store: KeyedStore<String>, values: KeyedStore<[String]>) {
        self.codingPath = codingPath
        self.store = store
        self.values = values
    }
    
    func decodeNil() -> Bool {
        false
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: String.Type) throws -> String {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        let value = type.increment(in: store)
        values[codingPath.map { $0.stringValue }] = value
        return value
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        if let type = type as? Incrementable.Type,
            let value = type.increment(in: store) as? T {
            values[codingPath.map { $0.stringValue }] = value
            return value
        } else if let type = type as? Randomizable.Type,
            let value = type.randomized() as? T {
            values[codingPath.map { $0.stringValue }] = value
            return value
        } else {
            let value = try type.init(from: KeyDecoder(codingPath: codingPath, store: store, values: values))
            values[codingPath.map { $0.stringValue }] = value
            return value
        }
    }
}
