//
//  SettingsModel.swift
//  SettingsMVVM
//
//  Created by Mereke on 08.04.2023.
//

import Foundation
import UIKit

struct Setting {
    let title: String
    let icon: UIImage?
    let hasToggle: Bool
    let isToggleOn: Bool
    let hasDisclosureIndicator: Bool
    let color: UIColor

    init(title: String = "", icon: UIImage? = UIImage(systemName: "bell"), hasToggle: Bool = false, isToggleOn: Bool = false, hasDisclosureIndicator: Bool = false, color: UIColor = .white) {
        self.title = title
        self.icon = icon
        self.hasToggle = hasToggle
        self.isToggleOn = isToggleOn
        self.hasDisclosureIndicator = hasDisclosureIndicator
        self.color = color
    }

    func getSettings() -> [[Setting]] {
            return [
                [
                Setting(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), hasToggle: true, isToggleOn: false, color: .systemBlue),
                Setting(title: "Wi-Fi", icon: UIImage(systemName: "wifi"), hasDisclosureIndicator: true, color: .systemGreen),
                Setting(title: "Bluetooth", icon: UIImage(systemName: "bolt.horizontal"), hasDisclosureIndicator: true, color: .systemPurple),
                Setting(title: "Cellular", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), hasDisclosureIndicator: true, color: .systemOrange),
                Setting(title: "Personal Hotspot", icon: UIImage(systemName: "personalhotspot"), hasDisclosureIndicator: true, color: .systemTeal),
                Setting(title: "VPN", icon: UIImage(systemName: "lock.shield"), hasDisclosureIndicator: true, color: .systemPink)
            ],
            [
                Setting(title: "Do Not Disturb", icon: UIImage(systemName: "moon"), hasToggle: true, isToggleOn: false, color: .systemRed),
                Setting(title: "General", icon: UIImage(systemName: "gear"), hasDisclosureIndicator: true, color: .systemBlue),
                Setting(title: "Control Center", icon: UIImage(systemName: "rectangle.grid.1x2"), hasDisclosureIndicator: true, color: .systemGreen),
                Setting(title: "Display & Brightness", icon: UIImage(systemName: "textformat.size"), hasDisclosureIndicator: true, color: .systemPurple),
                Setting(title: "Wallpaper", icon: UIImage(systemName: "photo.on.rectangle"), hasDisclosureIndicator: true, color: .systemOrange),
                Setting(title: "Sounds & Haptics", icon: UIImage(systemName: "speaker.wave.3"), hasDisclosureIndicator: true, color: .systemTeal),
                Setting(title: "Siri & Search", icon: UIImage(systemName: "mic.circle"), hasDisclosureIndicator: true, color: .systemPink),
                Setting(title: "Privacy", icon: UIImage(systemName: "lock.shield"), hasDisclosureIndicator: true, color: .systemRed),
                Setting(title: "Battery", icon: UIImage(systemName: "battery.100"), hasDisclosureIndicator: true, color: .systemBlue),
                Setting(title: "App Store", icon: UIImage(systemName: "bag"), hasDisclosureIndicator: true, color: .systemGreen)
            ],
            [
                Setting(title: "Wallet & Apple Pay", icon: UIImage(systemName: "creditcard"), hasDisclosureIndicator: true, color: .systemPurple),
                Setting(title: "Passwords", icon: UIImage(systemName: "key"), hasDisclosureIndicator: true, color: .systemOrange),
                Setting(title: "Mail", icon: UIImage(systemName: "envelope"), hasDisclosureIndicator: true, color: .systemTeal),
                Setting(title: "Contacts", icon: UIImage(systemName: "person.crop.circle"), hasDisclosureIndicator: true, color: .systemPink),
                Setting(title: "Calendars", icon: UIImage(systemName: "calendar"), hasDisclosureIndicator: true, color: .systemRed),
                Setting(title: "Maps", icon: UIImage(systemName: "map"), hasDisclosureIndicator: true, color: .systemBlue),
                Setting(title: "Notes", icon: UIImage(systemName: "note.text"), hasDisclosureIndicator: true, color: .systemGreen)]
        ]
    }
}
