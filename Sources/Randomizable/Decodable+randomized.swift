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

extension Decodable {
    /// Signature of the closure used for customizing the result of `randomized(customize:)`.
    public typealias Randomizing = (Any.Type) throws -> Any?

    /// Attempts to create a randomized instance of the receiver.
    ///
    /// Only `Randomizable` members are supported out of the box.
    /// For non-randomizable types you'll need to use the `customize` parameter in order to return a
    /// randomized instance of such values; otherwise the method will fail.

    /// - parameter customize: A closure for customizing the instance returned.
    /// - returns: A new instance of the receiver.
    /// - throws: An error if the instance cannot be created.
    public static func randomized(customize: Randomizing? = nil) throws -> Self {
        return try RandomSingleValueDecodingContainer(customize: customize).decode(Self.self)
    }
}
