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
import Idioms

extension Decodable {
    /// Signature of the closure used for customizing the result of `randomized(encoding:)`.
    public typealias JSONEncoding = (Any.Type, [CodingKey]) throws -> Data?

    /// Attempts to create a randomized instance of the receiver.
    /// Only basic data types are supported (i.e. `Bool`, `UInt`, `Int`, `Double`, `String`). For
    /// more complex types (e.g. enumerations, dates, urls...) you'll need to use the `encoding`
    /// parameter to return a valid JSON representation of such values.
    ///
    /// - parameter encoding: A closure for customizing the instance returned.
    /// - returns: A new instance of the receiver.
    /// - throws: An error if the instance cannot be created.
    public static func randomized(encoding: JSONEncoding? = nil) throws -> Self {
        return try guessRandomFromJSON(seed: "{}",
                                       encoding: encoding)
    }
    
    private static func guessRandomFromJSON(seed jsonString: String,
                                            encoding: JSONEncoding?) throws -> Self {
        guard let jsonData = jsonString.data(using: .utf8) else {
            throw Error.invalidSeed(jsonString: jsonString)
        }
        var randomObject: Self
        do {
            randomObject = try JSONDecoder().decode(Self.self, from: jsonData)
        } catch {
            guard let decodingError = error as? DecodingError else {
                throw Error.unknownError(underlyingError: error)
            }
            switch decodingError {
            case .keyNotFound(let key, let context):
                return try guessRandom(previousSeedData: jsonData,
                                       key: key,
                                       codingPath: context.codingPath,
                                       encoding: encoding)
            case .typeMismatch(let type, let context):
                return try guessRandom(previousSeedData: jsonData,
                                       type: type,
                                       codingPath: context.codingPath,
                                       encoding: encoding)
            case .valueNotFound(let type, let context):
                return try guessRandom(previousSeedData: jsonData,
                                       type: type,
                                       codingPath: context.codingPath,
                                       encoding: encoding)
            case .dataCorrupted(_):
                throw Error.invalidJsonStringSeed(underlyingError: decodingError)
            @unknown default:
                throw Error.unsupportedDecodingError(underlyingError: decodingError)
            }
        }
        return randomObject
    }
    
    private typealias SplittedCodingPath = (key: CodingKey, codingPath: [CodingKey])
    
    private static func splitCodingPath(_ fullCodingPath: [CodingKey]) -> SplittedCodingPath? {
        guard let key = fullCodingPath.last else {
            return nil
        }
        let newCodingPath = fullCodingPath.removingLast()
        return SplittedCodingPath(
            key: key,
            codingPath: newCodingPath
        )
    }
}

extension Decodable {
    fileprivate static func guessRandom(previousSeedData: Data,
                                        key: CodingKey,
                                        codingPath: [CodingKey],
                                        encoding: JSONEncoding?) throws -> Self {
        let nilSeed = try buildJsonSeed(with: nil,
                                        previousSeedData: previousSeedData,
                                        key: key,
                                        codingPath: codingPath)
        return try guessRandomFromJSON(seed: nilSeed,
                                       encoding: encoding)
    }
    
    fileprivate static func guessRandom(previousSeedData: Data,
                                        type: Any.Type,
                                        codingPath: [CodingKey],
                                        encoding: JSONEncoding?) throws -> Self {
        guard let splitted = splitCodingPath(codingPath) else {
            let value: Any? = try {
                if let data = try encoding?(type, codingPath) {
                    return try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
                } else {
                    return try makeRandomValue(for: type)
                }
                }()
            guard let random = value as? Self else {
                throw Error.cannotMakeJsonValue(type: Self.self)
            }
            return random
        }
        let value: Any? = try {
            if let data = try encoding?(type, codingPath) {
                return try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
            } else {
                return try makeRandomValue(for: type)
            }
            }()
        let newSeed = try buildJsonSeed(with: value,
                                        previousSeedData: previousSeedData,
                                        key: splitted.key,
                                        codingPath: splitted.codingPath)
        return try guessRandomFromJSON(seed: newSeed,
                                       encoding: encoding)
        
    }
    
    private static func buildJsonSeed(with value: Any?,
                                      previousSeedData data: Data,
                                      key: CodingKey,
                                      codingPath: [CodingKey]) throws -> String {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        guard let dictJson = json as? [String: Any?] else {
            throw Error.jsonIsNotDictionary(json: json)
        }
        var dictionary: [String: Any?] = [key.stringValue: value]
        for codingKey in codingPath.reversed() {
            dictionary = [codingKey.stringValue: dictionary]
        }
        let newJson = dictJson.deepMerging(dictionary)
        let data = try JSONSerialization.data(withJSONObject: newJson, options: [])
        guard let jsonSeed = String(data: data, encoding: .utf8) else {
            throw Error.cannotConvertJsonToString(jsonData: data)
        }
        return jsonSeed
    }
    
    private static func makeRandomValue(for type: Any.Type) throws -> Any? {
        if let randomizable = type.self as? Randomizable.Type {
            let anyValue =  randomizable.randomized()
            let jsonValue = try anyValueToJsonValue(anyValue)
            return jsonValue
        } else if String(describing: type) == String(describing: UnkeyedDecodingContainer.self) {
            return [Any]()
        } else { // assume KeyedDecodingContainer
            return [String: Any]()
        }
    }

    private static func anyValueToJsonValue(_ value: Any) throws -> Any {
        let valueData: Data
        if let value = value as? Date {
            valueData = try JSONEncoder().encode(value)
        } else if let value = value as? URL {
            valueData = try JSONEncoder().encode(value)
        } else if let value = value as? UUID {
            valueData = try JSONEncoder().encode(value)
        } else {
            return value
        }
        let jsonValue = try JSONSerialization.jsonObject(with: valueData, options: [.fragmentsAllowed])
        return jsonValue
    }
}

private protocol Optionable {
    var isNil: Bool { get }
}

extension Optional: Optionable {
    var isNil: Bool {
        switch self {
        case .none:
            return true
        case .some(let wrapped):
            guard let wrapped = wrapped as? Optionable else { return false }
            return wrapped.isNil
        }
    }
}
