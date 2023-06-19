//
//  SettingsInteractor.swift
//  SettingsVIP
//
//  Created by Mereke on 08.04.2023.
//

import Foundation

protocol SettingsInteractorProtocol {
    func fetchSettings()
}

class SettingsInteractor: SettingsInteractorProtocol {

    unowned let presenter: SettingsPresenterProtocol

    required init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }

    func fetchSettings() {
        let settings = Setting().getSettings()
        presenter.presentFetchedSettings(settings)
    }
}

