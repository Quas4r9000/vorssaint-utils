// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import AppKit
import CoreGraphics
import Foundation

/// Turns the right Option key into Forward Delete. The event tap swallows the
/// key's own flags-changed events and posts a Forward Delete on the down edge,
/// so a tap deletes the character after the cursor. The left Option key is
/// untouched, and nothing is installed while the feature is off. Requires
/// Accessibility: without it the tap cannot modify events, so the feature
/// stays off.
final class RightOptionDeleteService: ObservableObject {
    static let shared = RightOptionDeleteService()

    @Published private(set) var isRunning = false

    private var tap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?
    /// The right Option key reports its press and release as flags-changed
    /// events that share one modifier bit with the left Option key, so whether
    /// the key is down is tracked here instead of read from the flags.
    private var rightOptionIsDown = false
    /// Keeps deleting while the key is held, on the system's own repeat rhythm
    /// (the first repeat after `keyRepeatDelay`, then every `keyRepeatInterval`).
    private var repeatTimer: DispatchSourceTimer?

    private init() {}

    func syncWithPreferences() {
        let enabled = AppFeature.rightOptionDelete.isAvailable
            && UserDefaults.standard.bool(forKey: DefaultsKey.rightOptionDeleteEnabled)
        if enabled, Permissions.shared.accessibility {
            start()
        } else {
            stop()
        }
    }

    func suspend() { stop() }

    private func start() {
        guard tap == nil else { return }
        guard let tap = CGEvent.tapCreate(
            tap: .cgSessionEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: CGEventMask(1 << CGEventType.flagsChanged.rawValue),
            callback: { _, type, event, userInfo in
                guard let userInfo else { return Unmanaged.passUnretained(event) }
                let service = Unmanaged<RightOptionDeleteService>
                    .fromOpaque(userInfo).takeUnretainedValue()
                return service.handle(type: type, event: event)
            },
            userInfo: Unmanaged.passUnretained(self).toOpaque()
        ) else { return }
        self.tap = tap
        let source = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
        runLoopSource = source
        CFRunLoopAddSource(CFRunLoopGetMain(), source, .commonModes)
        CGEvent.tapEnable(tap: tap, enable: true)
        isRunning = true
    }

    private func stop() {
        if let tap { CGEvent.tapEnable(tap: tap, enable: false) }
        if let runLoopSource {
            CFRunLoopRemoveSource(CFRunLoopGetMain(), runLoopSource, .commonModes)
        }
        tap = nil
        runLoopSource = nil
        rightOptionIsDown = false
        stopRepeating()
        isRunning = false
    }

    private func handle(type: CGEventType, event: CGEvent) -> Unmanaged<CGEvent>? {
        if type == .tapDisabledByTimeout || type == .tapDisabledByUserInput {
            rightOptionIsDown = false
            stopRepeating()
            if let tap { CGEvent.tapEnable(tap: tap, enable: true) }
            return Unmanaged.passUnretained(event)
        }
        let keyCode = event.getIntegerValueField(.keyboardEventKeycode)
        guard RightOptionDeleteSupport.isRightOption(type: type, keyCode: keyCode) else {
            return Unmanaged.passUnretained(event)
        }
        // The key's events are swallowed either way: the down becomes Forward
        // Delete (and keeps deleting while held), and the up must not register
        // a modifier the down never set.
        if rightOptionIsDown {
            rightOptionIsDown = false
            stopRepeating()
        } else {
            rightOptionIsDown = true
            _ = RightOptionDeleteSupport.postForwardDelete()
            startRepeating()
        }
        return nil
    }

    // MARK: - Repeat while held

    private func startRepeating() {
        stopRepeating()
        let delay = NSEvent.keyRepeatDelay
        let interval = NSEvent.keyRepeatInterval
        let timer = DispatchSource.makeTimerSource(queue: .main)
        timer.schedule(deadline: .now() + (delay.isFinite && delay >= 0 ? delay : 0.5),
                       repeating: interval.isFinite && interval > 0 ? interval : 0.03,
                       leeway: .milliseconds(1))
        timer.setEventHandler {
            _ = RightOptionDeleteSupport.postForwardDelete()
        }
        repeatTimer = timer
        timer.resume()
    }

    private func stopRepeating() {
        repeatTimer?.cancel()
        repeatTimer = nil
    }
}
