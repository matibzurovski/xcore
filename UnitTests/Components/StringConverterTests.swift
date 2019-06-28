//
// StringConverterTests.swift
//
// Copyright © 2019 Xcore
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
//

import XCTest
@testable import Xcore

final class StringConverterTests: TestCase {
    func testGetValue() {
        XCTAssert(ConvertItem.validBool.value(default: false) == true)
        XCTAssert(ConvertItem.invalidBool.value(default: false) == false)

        XCTAssert(ConvertItem.validInt.value(default: 0) == Int(1213))
        XCTAssert(ConvertItem.invalidInt.value(default: 0) == Int(0))

        XCTAssert(ConvertItem.validFloat.value(default: 0) == Float(20.34))
        XCTAssert(ConvertItem.invalidFloat.value(default: 0) == Float(0))

        XCTAssert(ConvertItem.validDouble.value(default: 0) == Double(100.76))
        XCTAssert(ConvertItem.invalidDouble.value(default: 0) == Double(0))

        XCTAssert(ConvertItem.validNsNumber.value(default: NSNumber(value: 0)) == NSNumber(value: 10))
        XCTAssert(ConvertItem.invalidNsNumber.value(default: NSNumber(value: 0)) == NSNumber(value: 0))

        let defaultUrl = URL(string: "https://github.com/zmian/xcore.swift")!
        XCTAssert(ConvertItem.validUrl.value(default: defaultUrl) == URL(string: "https://swift.org/")!)
        XCTAssert(ConvertItem.invalidUrl.value(default: defaultUrl) == defaultUrl)

        let defaultString = "hello world"
        XCTAssert(ConvertItem.validString.value(default: defaultString) == "dark")
        XCTAssert(ConvertItem.invalidString.value(default: defaultString) == defaultString)

        let defaultArray: [String] = ["swift", "objc"]
        XCTAssert(ConvertItem.validArray.value(default: defaultArray) == ["red", "blue", "green"])
        XCTAssert(ConvertItem.invalidArray.value(default: defaultArray) == defaultArray)

        let validDictionary = [
            "name": "zmian",
            "framework": "Xcore",
            "language": "Swift"
        ]

        let defaultDictionary: [String: String] = ["hello": "world"]
        XCTAssert(ConvertItem.validDictionary.value(default: defaultDictionary) == validDictionary)
        XCTAssert(ConvertItem.invalidDictionary.value(default: defaultDictionary) == defaultDictionary)

        let expectedValueDark = ConvertItem.validRawRepresentable.value(default: TestTheme.light)
        let shouldBeDarkTheme = expectedValueDark == .dark
        XCTAssert(shouldBeDarkTheme)

        let expectedValueLight = ConvertItem.invalidRawRepresentable1.value(default: TestTheme.light)
        let shouldBeLightTheme = expectedValueLight == .light
        XCTAssert(shouldBeLightTheme)

        let expectedValueDark2 = ConvertItem.invalidRawRepresentable2.value(default: TestTheme.dark)
        let shouldBeDarkTheme2 = expectedValueDark2 == .dark
        XCTAssert(shouldBeDarkTheme2)
    }
}

// MARK: - ConvertValue

private struct ConvertValue {
    private var storage: [ConvertItem: Any] = [:]

    init() {
        let dictionaryExample = """
        {
            "name": "zmian",
            "framework": "Xcore",
            "language": "Swift"
        }
        """

        let arraryExample = """
        ["red", "blue", "green"]
        """

        storage[.validBool] = true
        storage[.invalidBool] = "no"

        storage[.validInt] = 1213
        storage[.invalidInt] = "two"

        storage[.validFloat] = 20.34
        storage[.invalidFloat] = "two"

        storage[.validDouble] = 100.76
        storage[.invalidDouble] = "two"

        storage[.validNsNumber] = NSNumber(value: 10)
        storage[.invalidNsNumber] = "hello world"

        storage[.validUrl] = "https://swift.org/"
        storage[.invalidUrl] = "hello world"

        storage[.validString] = "dark"
        storage[.invalidString] = InvalidString()

        storage[.validArray] = arraryExample
        storage[.invalidArray] = dictionaryExample

        storage[.validDictionary] = dictionaryExample
        storage[.invalidDictionary] = ""

        storage[.validRawRepresentable] = "dark"
        storage[.invalidRawRepresentable1] = "not dark"
        storage[.invalidRawRepresentable2] = 232
    }

    func value(for item: ConvertItem) -> StringConverter? {
        return StringConverter(storage[item]!)
    }

    struct InvalidString { }
}

// MARK: - ConvertItem

private enum ConvertItem: String {
    case validBool
    case invalidBool

    case validInt
    case invalidInt

    case validFloat
    case invalidFloat

    case validDouble
    case invalidDouble

    case validNsNumber
    case invalidNsNumber

    case validUrl
    case invalidUrl

    case validString
    case invalidString

    case validArray
    case invalidArray

    case validDictionary
    case invalidDictionary

    case validRawRepresentable
    case invalidRawRepresentable1
    case invalidRawRepresentable2
}

// MARK: - ConvertItem

extension ConvertItem {
    fileprivate var storageValue: FeatureFlag.Value? {
        return ConvertValue().value(for: self)
    }

    fileprivate func value<T>(default defaultValue: @autoclosure () -> T) -> T {
        return storageValue?.get() ?? defaultValue()
    }

    fileprivate func value<T>(default defaultValue: @autoclosure () -> T) -> T where T: RawRepresentable, T.RawValue == String {
        return storageValue?.get() ?? defaultValue()
    }
}

// MARK: - TestFeature

private enum TestTheme: String {
    case dark
    case light
}
