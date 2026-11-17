import Foundation

/// UI-facing state should be isolated to the main actor.
@MainActor
public final class ScreenState {
    public private(set) var message = "Ready"

    public init() {}

    public func show(_ newMessage: String) {
        message = newMessage
    }
}
