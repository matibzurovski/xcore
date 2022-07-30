//
// Xcore
// Copyright © 2017 Xcore
// MIT license, see LICENSE file for details
//

import SwiftUI

extension Money.Components {
    /// A structure representing fonts used to format money components.
    public struct Font: Hashable {
        /// The font for major unit of the amount.
        ///
        /// ```swift
        /// let amount = Decimal(120.30)
        /// // 120 - major unit
        /// // 30 - minor unit
        /// ```
        public var majorUnit: UIFont

        /// The font for minor unit of the amount.
        ///
        /// ```swift
        /// let amount = Decimal(120.30)
        /// // 120 - major unit
        /// // 30 - minor unit
        /// ```
        public var minorUnit: Superscript?

        /// The font for currency symbol of the amount.
        ///
        /// ```swift
        /// let amount = Decimal(120.30)
        /// // $ - currency symbol
        /// // 120 - major unit
        /// // 30 - minor unit
        /// ```
        public var currencySymbol: Superscript?

        /// Creates an instance of font.
        ///
        /// - Parameters:
        ///   - majorUnit: The font for major unit of the amount.
        ///   - minorUnit: The font for minor unit of the amount.
        ///   - currencySymbol: The font for currency symbol of the amount.
        public init(
            majorUnit: UIFont,
            minorUnit: Superscript?,
            currencySymbol: Superscript? = nil
        ) {
            self.majorUnit = majorUnit
            self.minorUnit = minorUnit
            self.currencySymbol = nil
        }

        /// Creates an instance of font.
        ///
        /// - Parameter font: The font for the amount.
        public init(_ font: UIFont) {
            self.majorUnit = font
            self.minorUnit = nil
            self.currencySymbol = nil
        }

        /// Creates an instance of font.
        ///
        /// - Parameter style: The font text style for the amount.
        public init(_ style: SwiftUI.Font.TextStyle) {
            self.init(.app(.init(style)))
        }
    }
}

// MARK: - Superscript

extension Money.Components.Font {
    /// A structure representing font and baseline offset.
    public struct Superscript: Hashable {
        public let font: UIFont
        public let baselineOffset: CGFloat

        public init(font: UIFont, baselineOffset: CGFloat) {
            self.font = font
            self.baselineOffset = baselineOffset
        }

        /// Returns superscript based layout derived from the given font text style.
        public static func relative(to style: Font.TextStyle) -> Self {
            relative(to: .app(.init(style)))
        }

        /// Returns superscript based layout derived from the given font point size.
        public static func relative(to font: UIFont) -> Self {
            let majorUnitSize = font.pointSize

            let φ = AppConstants.φ
            var minorUnitSize = (majorUnitSize * φ).rounded()

            // Add buffer if the given size is small. This helps with readability.
            if majorUnitSize <= 20 {
                minorUnitSize += (minorUnitSize * φ * φ * φ).rounded()
            }

            let minorUnitWeight: UIFont.Weight = minorUnitSize <= 10 ? .medium : .regular
            let minorUnitOffset = (majorUnitSize - minorUnitSize).rounded()

            return .init(
                font: .app(size: minorUnitSize, weight: minorUnitWeight),
                baselineOffset: minorUnitOffset
            )
        }
    }
}

// MARK: - Chaining Syntactic Syntax

extension Money.Components.Font {
    /// Superscripts currency symbol relative to the major unit.
    public func currencySymbolSuperscript() -> Self {
        currencySymbol(.relative(to: majorUnit))
    }

    /// The font for currency symbol of the amount.
    public func currencySymbol(font: UIFont, baselineOffset: CGFloat) -> Self {
        currencySymbol(.init(font: font, baselineOffset: baselineOffset))
    }

    /// The font for currency symbol of the amount.
    public func currencySymbol(_ superscript: Superscript?) -> Self {
        var copy = self
        copy.currencySymbol = superscript
        return copy
    }
}

// MARK: - Built-in Superscript: Minor Unit

extension Money.Components.Font {
    /// Superscripts minor unit relative to the given font text style.
    public static func superscript(_ style: Font.TextStyle) -> Self {
        superscript(.app(.init(style)))
    }

    /// Superscripts minor unit relative to the given font.
    public static func superscript(_ font: UIFont) -> Self {
        .init(majorUnit: font, minorUnit: .relative(to: font))
    }
}

// MARK: - Built-in

extension Money.Components.Font {
    /// A font with the large title text style.
    public static var largeTitle: Self {
        .init(.largeTitle)
    }

    /// A font with the title text style.
    public static var title: Self {
        .init(.title)
    }

    /// A font with the second level hierarchical headings.
    public static var title2: Self {
        .init(.title2)
    }

    /// A font with the third level hierarchical headings.
    public static var title3: Self {
        .init(.title3)
    }

    /// A font with the headline text style.
    public static var headline: Self {
        .init(.headline)
    }

    /// A font with the subheadline text style.
    public static var subheadline: Self {
        .init(.subheadline)
    }

    /// A font with the body text style.
    public static var body: Self {
        .init(.body)
    }

    /// A font with the callout text style.
    public static var callout: Self {
        .init(.callout)
    }

    /// A font with the footnote text style.
    public static var footnote: Self {
        .init(.footnote)
    }

    /// A font with the caption text style.
    public static var caption: Self {
        .init(.caption)
    }

    /// A font with the alternate caption text style.
    public static var caption2: Self {
        .init(.caption2)
    }
}
