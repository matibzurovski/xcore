//
// Xcore
// Copyright © 2021 Xcore
// MIT license, see LICENSE file for details
//

import SwiftUI

extension Text {
    /// Creates a text view that displays a stored string without localization.
    @_disfavoredOverload
    public init?<S>(_ content: S?) where S: StringProtocol {
        guard let content else {
            return nil
        }

        self.init(content)
    }

    public init<S>(_ string: S, configure: (inout AttributedString) -> Void) where S: StringProtocol {
        var attributedString = AttributedString(string)
        configure(&attributedString)
        self.init(attributedString)
    }

    /// Creates text view that scales the provided portion of the text based on the
    /// font than the rest.
    public init(_ content: String, scale scaledContent: String, font: Font) {
        self.init(content) { string in
            if let range = string.range(of: scaledContent) {
                string[range].font = font
            }
        }
    }

    public init(_ error: Error) {
        self.init([error.title, error.message].joined(separator: "\n\n"))
    }
}
