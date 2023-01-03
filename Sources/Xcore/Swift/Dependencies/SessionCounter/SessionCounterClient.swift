//
// Xcore
// Copyright © 2022 Xcore
// MIT license, see LICENSE file for details
//

import Foundation

/// Provides functionality to keep track of user's session counts.
public protocol SessionCounterClient {
    /// Returns user's current session count.
    var count: Int { get }

    /// Increments user's session count.
    func increment()
}

// MARK: - Dependency

extension DependencyValues {
    private struct SessionCounterClientKey: DependencyKey {
        static var liveValue: SessionCounterClient = .live
    }

    /// Provides functionality to keep track of user's session counts.
    public var sessionCounter: SessionCounterClient {
        get { self[SessionCounterClientKey.self] }
        set { self[SessionCounterClientKey.self] = newValue }
    }

    /// Provides functionality to keep track of user's session counts.
    @discardableResult
    public static func sessionCounter(_ value: SessionCounterClient) -> Self.Type {
        SessionCounterClientKey.liveValue = value
        return Self.self
    }
}
