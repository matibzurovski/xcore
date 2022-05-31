//
// Xcore
// Copyright © 2014 Xcore
// MIT license, see LICENSE file for details
//

import Foundation
import CoreGraphics

// MARK: - Int

extension Int {
    private static let numberFormatter = NumberFormatter().apply {
        $0.paddingPosition = .beforePrefix
        $0.paddingCharacter = "0"
    }

    public func pad(by amount: Int) -> String {
        Self.numberFormatter.minimumIntegerDigits = amount
        return Self.numberFormatter.string(from: self)!
    }
}

extension FixedWidthInteger {
    /// Returns an array containing the results of mapping the given closure over
    /// `self`.
    ///
    /// ```swift
    /// let values = 10.map { $0 * 2 }
    /// print(values)
    ///
    /// // prints
    /// [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
    /// ```
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an element of
    ///   `self` as its parameter and returns a transformed value of the same or of
    ///   a different type.
    /// - Returns: An array containing the transformed elements of `self`.
    /// - Complexity: O(_n_).
    public func map<T>(transform: (Self) throws -> T) rethrows -> [T] {
        var results = [T]()
        for i in 0..<self {
            try results.append(transform(i + 1))
        }
        return results
    }
}

extension SignedInteger {
    public var digitsCount: Self {
        numberOfDigits(in: self)
    }

    private func numberOfDigits(in number: Self) -> Self {
        if abs(number) < 10 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number / 10)
        }
    }
}

extension UnsignedInteger {
    public var digitsCount: Self {
        numberOfDigits(in: self)
    }

    private func numberOfDigits(in number: Self) -> Self {
        if number < 10 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number / 10)
        }
    }
}

extension FloatingPoint {
    public static var pi2: Self {
        .pi / 2
    }

    public static var pi4: Self {
        .pi / 4
    }
}

// MARK: - Sum

extension Sequence where Iterator.Element: AdditiveArithmetic {
    /// Returns the running sum of all elements in the collection.
    ///
    /// ```swift
    /// [1, 1, 1, 1, 1, 1].runningSum() // -> [1, 2, 3, 4, 5, 6]
    /// ```
    public func runningSum() -> [Iterator.Element] {
        reduce([]) { sums, element in
            sums + [element + (sums.last ?? .zero)]
        }
    }

    /// Returns the sum of all elements in the collection.
    public func sum() -> Element {
        reduce(.zero, +)
    }
}

extension Sequence {
    /// Returns the sum of all elements in the collection using the given closure.
    ///
    /// ```swift
    /// struct Expense {
    ///     let title: String
    ///     let amount: Double
    /// }
    ///
    /// let expenses = [
    ///     Expense(title: "Laptop", amount: 1200),
    ///     Expense(title: "Chair", amount: 1000)
    /// ]
    ///
    /// let totalCost = expenses.sum { $0.amount }
    /// print(totalCost)
    ///
    /// // prints
    /// 2200.0
    /// ```
    public func sum<T: AdditiveArithmetic>(_ transform: (Element) throws -> T) rethrows -> T {
        try reduce(T.zero) { sum, element in
            sum + (try transform(element))
        }
    }
}

// MARK: - Average

extension Collection where Iterator.Element: BinaryInteger {
    /// Returns the average of all elements in the collection.
    public func average() -> Double {
        isEmpty ? 0 : Double(sum()) / Double(count)
    }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the collection.
    public func average() -> Element {
        isEmpty ? 0 : sum() / Element(count)
    }
}

extension Collection where Element == Decimal {
    /// Returns the average of all elements in the collection.
    public func average() -> Decimal {
        isEmpty ? 0 : sum() / Decimal(count)
    }
}

extension Double {
    /// Returns this value rounded to an integral value using the specified rounding
    /// fraction digits.
    ///
    /// ```swift
    /// 1      → "1.00"
    /// 1.09   → "1.09"
    /// 1.9    → "1.90"
    /// 2.1345 → "2.13"
    /// 2.1355 → "2.14"
    /// ```
    ///
    /// - Parameters:
    ///   - rule: The rounding rule to use.
    ///   - fractionDigits: The number of digits result can have after its decimal
    ///     point.
    public func rounded(
        _ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero,
        fractionDigits: Int
    ) -> Double {
        let multiplier = pow(10.0, Double(fractionDigits))
        return (self * multiplier).rounded(rule) / multiplier
    }

    /// Returns this value rounded to an integral value using the specified rounding
    /// fraction digits.
    ///
    /// - Parameters:
    ///   - rule: The rounding rule to use.
    ///   - fractionDigits: The number of digits result can have after its decimal
    ///     point.
    public func formatted(
        _ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero,
        fractionDigits: Int
    ) -> String {
        String(
            format: "%.\(fractionDigits)f%",
            rounded(rule, fractionDigits: fractionDigits)
        )
    }
}

extension Double {
    public init(truncating number: Decimal) {
        self.init(truncating: NSDecimalNumber(decimal: number))
    }

    @_disfavoredOverload
    public init?(any value: Any?) {
        guard let value = value else {
            return nil
        }

        if let value = value as? LosslessStringConvertible {
            self.init(value.description)
            return
        }

        if let cgfloat = value as? CGFloat {
            self.init(cgfloat)
            return
        }

        if let double = (value as? Decimal)?.doubleValue {
            self.init(double)
            return
        }

        return nil
    }
}

// MARK: - Comparable

extension Comparable {
    /// Returns a copy of `self` clamped to the given limiting range.
    ///
    /// ```swift
    /// 30.clamped(to: 0...10) // returns 10
    /// 3.0.clamped(to: 0.0...10.0) // returns 3.0
    /// "z".clamped(to: "a"..."x") // returns "x"
    /// ```
    public func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}

// MARK: - Formatted

extension Double {
    private static let formatter = NumberFormatter().apply {
        $0.numberStyle = .decimal
        $0.maximumFractionDigits = .maxFractionDigits
    }

    @available(iOS, introduced: 14, deprecated: 15, message: "Use .formattedString() directly.")
    public func formattedString() -> String {
        Self.formatter.string(from: self) ?? ""
    }

//    @available(iOS 15.0, *)
//    public func formattedString() -> String {
//        formatted(.number.precision(.fractionLength(0...Int.maxFractionDigits)))
//    }
}

// MARK: - Formatted

extension Decimal {
    private static let usPosixFormatter = NumberFormatter().apply {
        $0.numberStyle = .decimal
        $0.maximumFractionDigits = .maxFractionDigits
        $0.locale = .usPosix
    }

    private static let formatter = NumberFormatter().apply {
        $0.numberStyle = .decimal
        $0.maximumFractionDigits = .maxFractionDigits
    }

    @available(iOS, introduced: 14, deprecated: 15, message: "Use .formattedString() directly.")
    public func formattedString() -> String {
        Self.formatter.string(from: self) ?? ""
    }

    fileprivate var doubleValue: Double? {
        guard let stringValue = Self.usPosixFormatter.string(from: self) else {
            return nil
        }

        return Double(stringValue)
    }

    public var double: Double {
        doubleValue ?? 0
    }

//    @available(iOS 15.0, *)
//    public func formattedString() -> String {
//        formatted(.number.precision(.fractionLength(0...Int.maxFractionDigits)))
//    }
}

extension Int {
    static var maxFractionDigits: Int { 100 }
}
