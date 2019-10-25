# Randomizable

`Decodable` extension that adds a static method that can create randomized instances of the receiver.

## Example

Given a some `Decodable` type:

```swift
struct Foo: Decodable {
    struct Inner: Decodable {
        let bool: Bool?
        let array: [String]
    }
    let double: Double
    let string: String
    let nested: Inner
}
```

You can use Randomizable to create a randomized instance:

```swift
import Randomizable

let instance = try Foo.randomized() 
```

See more examples in the [tests](./Tests/RandomizableTests/DecodableRandomizedTests.swift).

## License

Randomizable is available under the MIT license. See the LICENSE file for more info.
