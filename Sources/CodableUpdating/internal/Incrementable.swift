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

protocol Incrementable: Randomizable {
    static func increment(in store: KeyedStore<String>) -> Self
    func incremented() -> Self
}

extension Incrementable {
    static func increment(in store: KeyedStore<String>) -> Self {
        let key = String(describing: self)
        let currentValue = store[key] as? Self ?? Self.randomized()
        let incrementedValue = currentValue.incremented()
        store[key] = incrementedValue
        return incrementedValue
    }
}

extension FloatingPoint {
    func incremented() -> Self {
        self + 1
    }
}

extension Double: Incrementable {}
extension Float: Incrementable {}

extension FixedWidthInteger {
    func incremented() -> Self {
        self + 1
    }
}

extension Int: Incrementable {}
extension Int8: Incrementable {}
extension Int16: Incrementable {}
extension Int32: Incrementable {}
extension Int64: Incrementable {}
extension UInt: Incrementable {}
extension UInt8: Incrementable {}
extension UInt16: Incrementable {}
extension UInt32: Incrementable {}
extension UInt64: Incrementable {}

extension Bool: Incrementable {
    func incremented() -> Self {
        !self
    }
}

extension String: Incrementable {
    func incremented() -> Self {
        String(Int(self)?.incremented() ?? 0)
    }
}

extension Data: Incrementable {
    func incremented() -> Self {
        (String(data: self, encoding: .utf8)?.incremented() ?? "0")
            .data(using: .utf8)!
    }
}

extension UUID: Incrementable {
    func incremented() -> Self {
        return UUID()
    }
}

extension URL: Incrementable {
    func incremented() -> Self {
        return URL(fileURLWithPath: absoluteString.incremented())
    }
}

extension Date: Incrementable {
    func incremented() -> Self {
        addingTimeInterval(1)
    }
}

extension Optional: Incrementable where Wrapped: Incrementable {
    func incremented() -> Self {
        switch self {
        case .some(let wrapped): return wrapped.incremented()
        case .none: return Wrapped.randomized()
        }
    }
}

extension Array: Incrementable where Element: Incrementable {
    func incremented() -> Self {
        if let last = last {
            return appending(last.incremented())
        } else {
            return [Element.randomized()]
        }
    }
}

extension Dictionary: Incrementable where Key: Incrementable, Value: Randomizable {
    func incremented() -> Self {
        if let last = (keys.sorted { String(describing: $0) < String(describing: $1) }.last) {
            var copy = self
            copy[last.incremented()] = Value.randomized()
            return copy
        } else {
            var copy = [Key: Value]()
            copy[Key.randomized()] = Value.randomized()
            return copy
        }
    }
}
