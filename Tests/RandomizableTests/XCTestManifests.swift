#if !canImport(ObjectiveC)
import XCTest

extension CodableRandomizedTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CodableRandomizedTests = [
        ("testRandomized", testRandomized),
        ("testRandomizedWithCustomEncoding", testRandomizedWithCustomEncoding),
    ]
}

extension RandomizableFoundationTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RandomizableFoundationTests = [
        ("testDataChanges", testDataChanges),
        ("testDateChanges", testDateChanges),
        ("testURLChanges", testURLChanges),
        ("testUUIDChanges", testUUIDChanges),
    ]
}

extension RandomizableInternalsTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RandomizableInternalsTests = [
        ("testArrayCountCanBeOne", testArrayCountCanBeOne),
    ]
}

extension RandomizableSwiftTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RandomizableSwiftTests = [
        ("testArrayCanBeNonEmpty", testArrayCanBeNonEmpty),
        ("testArrayChanges", testArrayChanges),
        ("testArrayOfCodablesCanBeEmpty", testArrayOfCodablesCanBeEmpty),
        ("testArrayOfCodablesCanBeNonEmpty", testArrayOfCodablesCanBeNonEmpty),
        ("testArrayOfCodablesChanges", testArrayOfCodablesChanges),
        ("testBoolCanBeFalse", testBoolCanBeFalse),
        ("testBoolCanBeTrue", testBoolCanBeTrue),
        ("testDictionaryCanBeNonEmpty", testDictionaryCanBeNonEmpty),
        ("testDictionaryChanges", testDictionaryChanges),
        ("testDictionaryWithCodablesCanBeEmpty", testDictionaryWithCodablesCanBeEmpty),
        ("testDictionaryWithCodablesCanBeNonEmpty", testDictionaryWithCodablesCanBeNonEmpty),
        ("testDictionaryWithCodablesChanges", testDictionaryWithCodablesChanges),
        ("testDoubleCanBeNegative", testDoubleCanBeNegative),
        ("testDoubleCanBePositive", testDoubleCanBePositive),
        ("testDoubleChanges", testDoubleChanges),
        ("testFloatCanBeNegative", testFloatCanBeNegative),
        ("testFloatCanBePositive", testFloatCanBePositive),
        ("testFloatChanges", testFloatChanges),
        ("testIntCanBeNegative", testIntCanBeNegative),
        ("testIntCanBePositive", testIntCanBePositive),
        ("testIntChanges", testIntChanges),
        ("testOptionalCanBeNonNil", testOptionalCanBeNonNil),
        ("testOptionalChanges", testOptionalChanges),
        ("testStringCanBeNonEmpty", testStringCanBeNonEmpty),
        ("testStringChanges", testStringChanges),
        ("testUIntCanBeNonZero", testUIntCanBeNonZero),
        ("testUIntChanges", testUIntChanges),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CodableRandomizedTests.__allTests__CodableRandomizedTests),
        testCase(RandomizableFoundationTests.__allTests__RandomizableFoundationTests),
        testCase(RandomizableInternalsTests.__allTests__RandomizableInternalsTests),
        testCase(RandomizableSwiftTests.__allTests__RandomizableSwiftTests),
    ]
}
#endif
