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

struct KeyDecoder: Decoder {
    var store: KeyedStore<String>
    var values: KeyedStore<[String]>
    
    var codingPath: [CodingKey]
    
    var userInfo: [CodingUserInfoKey : Any] {
        [:]
    }
    
    init(codingPath: [CodingKey], store: KeyedStore<String>, values: KeyedStore<[String]>) {
        self.codingPath = codingPath
        self.store = store
        self.values = values
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        KeyedDecodingContainer<Key>(KeyKeyedDecodingContainer<Key>(codingPath: codingPath, store: store, values: values))
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        KeyUnkeyedDecodingContainer(codingPath: codingPath, store: store, values: values)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        KeySingleValueDecodingContainer(codingPath: codingPath, store: store, values: values)
    }
}
