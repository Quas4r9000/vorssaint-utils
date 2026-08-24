// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import SwiftUI

struct RightOptionDeleteSettings: View {
    @ObservedObject private var l10n = L10n.shared
    @ObservedObject private var permissions = Permissions.shared
    @ObservedObject private var service = RightOptionDeleteService.shared
    @AppStorage(DefaultsKey.rightOptionDeleteEnabled) private var enabled = false

    private var text: RightOptionDeleteStrings { FeatureStrings.rightOptionDelete(l10n.language) }

    var body: some View {
        Form {
            Section(text.pageTitle) {
                Toggle(text.enableToggle, isOn: $enabled)
                    .onChange(of: enabled) { _, value in
                        RightOptionDeleteService.shared.syncWithPreferences()
                        guard value, !permissions.accessibility else { return }
                        permissions.requestAccessibility()
                        permissions.openAccessibilitySettings()
                    }
                Text(text.enableCaption)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                if enabled, service.isRunning {
                    Label(text.activeNow, systemImage: "checkmark.circle.fill")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
            }

            if enabled, !permissions.accessibility {
                Section(l10n.s.permissionRequired) {
                    PermissionRow(kind: .accessibility)
                }
            }
        }
        .formStyle(.grouped)
    }
}
