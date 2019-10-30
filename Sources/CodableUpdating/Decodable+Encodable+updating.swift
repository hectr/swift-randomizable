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

extension Decodable where Self: Encodable {
    public func updating<T: Codable>(_ keyPath: WritableKeyPath<Self, T>, to value: T) -> Self {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }

    public func updating<T: Codable>(_ keyPath: KeyPath<Self, T>, to value: T) -> Self {
        // Find all values contained in the receiver:
        let valuesStore = KeyedStore<[String]>() // <-- will map coding paths with their corresponding values
        let object = try! KeySingleValueDecodingContainer(codingPath: [],
                                                          store: KeyedStore<String>(),
                                                          values: valuesStore)
            .decode(Self.self) // <-- in this new instance of Self, there shouldn't be duplicated values
        
        // TODO: deal with duplicated values in valuesStore to obtain the correct coding path
        
        // Match the KeyPath with the equivalent coding path:
        let keyPathValue = object[keyPath: keyPath]
        let keyPathData = try! JSONEncoder().encode(keyPathValue)
        var keyPathKeys: [String]?
        for (key, value) in valuesStore.wrapped {
            guard let value = value as? T,
                let data = try? JSONEncoder().encode(value),
                data == keyPathData else {
                continue
            }
            keyPathKeys = key
            break
        }
        guard let keys = keyPathKeys else {
            fatalError("Could not convert KeyPath<\(String(describing: Self.self)), \(String(describing: T.self))> into a coding path")
        }

        // Return the updated instance:
        return updating(keys, to: value)
    }

    private func updating<T: Codable>(_ keys: [String], to value: T) -> Self {
        // Get a JSON representation of the receiver:
        let data = try! JSONEncoder().encode(self)
        var json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any?]

        // Get a JSON representation of the updated value:
        let valueData = try! JSONEncoder().encode(value)
        let jsonValue = try! JSONSerialization.jsonObject(with: valueData, options: [.fragmentsAllowed])

        // Apply the updated value to the receiver's JSON representation:
        var values = [Any?]()
        for key in keys {
            let dict = (values.last ?? json) as! [String: Any?]
            let subdict = dict[key]!
            values.append(subdict)
        }
        values.removeLast()
        values.append(jsonValue)
        var updated = [String:Any?]()
        for (key, value) in zip(keys, values).reversed() {
            if updated.count > 0 {
                updated = [key: value].deepMerging([key: updated])
            } else {
                updated = [key: value]
            }
        }
        json = json.deepMerging(updated)

        // Decode the updated JSON representation into a new instance:
        let newData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let newObject = try! JSONDecoder().decode(Self.self, from: newData)

        // Check that the update happened and return the updated instance:
        assert(
            (json as NSDictionary).removingNulls() == newObject.toJsonDictionary().removingNulls(),
            """
            New instance failed to update given KeyPath<\(String(describing: Self.self)), \(String(describing: T.self))> (\(keys)) to '\(value)'.
            """
        )
        return newObject
    }
}

#if DEBUG
extension NSDictionary {
    fileprivate func removingNulls() -> NSDictionary {
        let pruned = NSMutableDictionary()
        for key in allKeys {
            if let value = self[key], (value as? NSNull) != NSNull() {
                pruned[key] = value
            }
        }
        return pruned
    }
}

extension Encodable {
    fileprivate func toJsonDictionary() -> NSDictionary {
        let data = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
    }
}
#endif
