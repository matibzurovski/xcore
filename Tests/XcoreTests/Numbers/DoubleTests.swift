//
// Xcore
// Copyright © 2019 Xcore
// MIT license, see LICENSE file for details
//

import XCTest
@testable import Xcore

final class DoubleTests: TestCase {
    func testInitAny() {
        XCTAssertEqual(Double(any: "2.5"), 2.5)
        XCTAssertEqual(Double(any: Int(-7)), -7)
        XCTAssertEqual(Double(any: UInt(7)), 7)
        XCTAssertEqual(Double(any: CGFloat(2.5)), 2.5)
        XCTAssertEqual(Double(any: CGFloat(0.07)), 0.07)
        XCTAssertEqual(Double(any: Double(2.5)), 2.5)
        XCTAssertEqual(Double(any: Double(0.07)), 0.07)
        XCTAssertEqual(Double(any: Decimal(0.07)), 0.07)
        XCTAssertEqual(Double(any: Decimal(315.36)), 315.36)
        XCTAssertEqual(Double(any: Decimal(9.28)), 9.28)
        XCTAssertEqual(Double(any: Decimal(0.1736)), 0.1736)
        XCTAssertEqual(Double(any: Decimal(0.000001466)), 0.000001466)
    }

    func testInitTruncating() {
        XCTAssertEqual(Double(truncating: Decimal(string: "2.5", locale: .us)!), 2.5)
        XCTAssertEqual(Double(truncating: Decimal(2.5)), 2.5)

        XCTAssertEqual(Double(truncating: Decimal(string: "-7", locale: .us)!), -7)
        XCTAssertEqual(Double(truncating: Decimal(-7)), -7)

        XCTAssertNotEqual(Double(truncating: Decimal(string: "0.07", locale: .us)!), 0.07)
        XCTAssertNotEqual(Double(truncating: Decimal(0.07)), 0.07)

        XCTAssertEqual(Double(truncating: Decimal(string: "315.36", locale: .us)!), 315.36)
        XCTAssertEqual(Double(truncating: Decimal(315.36)), 315.3600000000001)
        XCTAssertEqual(Double(any: Decimal(315.36)), 315.36)

        XCTAssertEqual(Double(truncating: Decimal(string: "9.28", locale: .us)!), 9.28)
        XCTAssertEqual(Double(truncating: Decimal(9.28)), 9.28)

        XCTAssertEqual(Double(truncating: Decimal(string: "0.1736", locale: .us)!), 0.1736)
        XCTAssertEqual(Double(truncating: Decimal(0.1736)), 0.1736)

        XCTAssertEqual(NSDecimalNumber(decimal: Decimal(0.07)).doubleValue, 0.07000000000000003)
        XCTAssertEqual(Double(any: Decimal(string: "0.07", locale: .us)!), 0.07)
        XCTAssertEqual(Decimal(0.07), 0.07)
        XCTAssertEqual(NSDecimalNumber(decimal: Decimal(string: "0.07", locale: .us)!).doubleValue, 0.06999999999999999)
        XCTAssertEqual(NSNumber(value: Double(0.07)).doubleValue, 0.07)
        XCTAssertEqual(0.07, 0.07)

        XCTAssertNotEqual(Double(truncating: Decimal(string: "0.000001466", locale: .us)!), 0.000001466)
        XCTAssertNotEqual(Double(truncating: Decimal(0.000001466)), 0.000001466)
    }

    func testFormatted() {
        XCTAssertEqual(Double(1).formatted(fractionDigits: 2), "1.00")
        XCTAssertEqual(Double(1.09).formatted(fractionDigits: 2), "1.09")
        XCTAssertEqual(Double(1.9).formatted(fractionDigits: 2), "1.90")
        XCTAssertEqual(Double(1.1345).formatted(fractionDigits: 2), "1.13")
        XCTAssertEqual(Double(1.1355).formatted(fractionDigits: 2), "1.14")
        XCTAssertEqual(Double(1.1355).formatted(fractionDigits: 3), "1.136")

        XCTAssertEqual(Double(9.28).formatted(fractionDigits: 3), "9.280")
        XCTAssertEqual(Double(0.1736).formatted(fractionDigits: 4), "0.1736")
        XCTAssertEqual(Double(0.1736).formatted(fractionDigits: 2), "0.17")
        XCTAssertEqual(Double(0.000001466).formatted(fractionDigits: 9), "0.000001466")
        XCTAssertEqual(Double(0.000001466).formatted(fractionDigits: 8), "0.00000147")
        XCTAssertEqual(Double(0.000001466).formatted(fractionDigits: 3), "0.000")

        // trunc
        XCTAssertEqual(Double(1.1355).formatted(.towardZero, fractionDigits: 3), "1.135")
    }
}
