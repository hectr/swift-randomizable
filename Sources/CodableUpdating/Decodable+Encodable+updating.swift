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

extension Decodable where Self: Encodable {
    public func updating<T: Codable>(_ keyPath: WritableKeyPath<[String: Any], Any?>, to value: T) -> Self {
        let data = try! JSONEncoder().encode(self)
        var json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let valueData = try! JSONEncoder().encode(value)
        let jsonValue = try! JSONSerialization.jsonObject(with: valueData, options: [.fragmentsAllowed])
        json[keyPath: keyPath] = jsonValue
        let newData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let newObject = try! JSONDecoder().decode(Self.self, from: newData)
        assert(
            try! NSDictionary(dictionary: json).removingNulls() == (JSONSerialization.jsonObject(with: JSONEncoder().encode(newObject), options: []) as! NSDictionary).removingNulls(),
            """
            New instance failed to update '\(keyPath)' to '\(value)'.
            If you are using a customized CodingKeys enum with alternative keys you must provide your own implementation of \(#function).
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
#endif
