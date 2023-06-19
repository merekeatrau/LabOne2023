//
//  SettingsPresenter.swift
//  Settings
//
//  Created by Mereke on 08.04.2023.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol)
    func setSettings()
}

class SettingsPresenter: SettingsPresenterProtocol {

    unowned let view: SettingsViewProtocol
    private let setting = Setting()

    required init(view: SettingsViewProtocol) {
        self.view = view
    }

    func setSettings() {
        let setting = setting.getSettings()
        view.setSettings(setting)
    }
}




