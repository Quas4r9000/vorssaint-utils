// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Carbon.HIToolbox
import CoreGraphics
import Foundation

/// The pure half of the right-Option-to-forward-delete remap: which key is
/// involved and how a tap on it is turned into Forward Delete.
enum RightOptionDeleteSupport {
    /// The right Option key, as it arrives in flags-changed events. The left
    /// Option key reports a different code, so it is never touched.
    static let rightOptionKeyCode: Int64 = Int64(kVK_RightOption)
    /// The key a tap on right Option stands for.
    static let forwardDeleteKeyCode = CGKeyCode(kVK_ForwardDelete)

    /// Whether a flags-changed event is the right Option key changing state.
    static func isRightOption(type: CGEventType, keyCode: Int64) -> Bool {
        type == .flagsChanged && keyCode == rightOptionKeyCode
    }

    /// Posts a single Forward Delete press and release at the HID tap, so it
    /// reaches the focused app without looping through the remap's own tap.
    /// The flags are cleared explicitly: a freshly created keyboard event
    /// inherits the currently held modifiers, and with the right Option still
    /// down that would turn a one-character delete into delete-to-word-end.
    static func postForwardDelete() -> Bool {
        let source = CGEventSource(stateID: .hidSystemState)
        guard let down = CGEvent(keyboardEventSource: source,
                                 virtualKey: forwardDeleteKeyCode,
                                 keyDown: true),
              let up = CGEvent(keyboardEventSource: source,
                               virtualKey: forwardDeleteKeyCode,
                               keyDown: false)
        else { return false }
        down.flags = []
        up.flags = []
        down.post(tap: .cghidEventTap)
        up.post(tap: .cghidEventTap)
        return true
    }
}
