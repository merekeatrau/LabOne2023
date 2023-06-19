//
//  SettingsViewModel.swift
//  SettingsMVVM
//
//  Created by Mereke on 08.04.2023.
//

import Foundation

protocol SettingsViewModelProtocol {
    func setSettings()
    var settings: [[Setting]]? { get set }
    var didShowSettings: ((SettingsViewModelProtocol) -> Void)? { get set }
}

final class SettingsViewModel: SettingsViewModelProtocol {
    var settings: [[Setting]]? {
        didSet {
            didShowSettings?(self)
        }
    }

    var didShowSettings: ((SettingsViewModelProtocol) -> Void)?

    func setSettings() {
        settings = Setting().getSettings()
    }
}
