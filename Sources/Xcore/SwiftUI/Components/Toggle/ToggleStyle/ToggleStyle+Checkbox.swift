//
// Xcore
// Copyright © 2020 Xcore
// MIT license, see LICENSE file for details
//

import SwiftUI

extension CheckboxToggleStyle {
    public enum Placement {
        case left
        case right
    }
}

public struct CheckboxToggleStyle: ToggleStyle {
    private var placement: Placement

    public init(placement: Placement = .right) {
        self.placement = placement
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            if placement == .right {
                configuration.label
                Spacer()
                toggle(configuration)
            } else {
                toggle(configuration)
                Spacer()
                    .frame(width: .s4)
                configuration.label
                Spacer()
            }
        }
    }

    private func toggle(_ configuration: Self.Configuration) -> some View {
        EnvironmentReader(\.theme) { theme in
            Image(system: configuration.isOn ? .checkmarkCircleFill : .circle)
                .resizable()
                .frame(24)
                .foregroundColor(
                    configuration.isOn ? .accentColor : theme.separatorColor
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

// MARK: - Dot Syntax Support

extension ToggleStyle where Self == CheckboxToggleStyle {
    public static var checkbox: Self { .init() }

    public static func checkbox(placement: Self.Placement) -> Self {
        .init(placement: placement)
    }
}
