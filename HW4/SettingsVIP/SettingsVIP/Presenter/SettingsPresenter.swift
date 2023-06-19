//
//  SettingsPresenter.swift
//  SettingsVIP
//
//  Created by Mereke on 08.04.2023.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    func presentFetchedSettings(_ settings: [[Setting]])
}


class SettingsPresenter: SettingsPresenterProtocol {
    unowned let view: SettingsViewProtocol

    init(view: SettingsViewProtocol) {
        self.view = view
    }

    func presentFetchedSettings(_ settings: [[Setting]]) {
        view.showSettings(settings)
    }
}
