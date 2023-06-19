//
//  ViewController.swift
//  SettingsVIP
//
//  Created by Mereke on 08.04.2023.
//

import UIKit
import SnapKit

protocol SettingsViewProtocol: AnyObject {
    func showSettings(_ settings: [[Setting]])
}

class SettingsViewController: UIViewController {
    private let tableView = SettingsTableView()
    private let searchController = SearchController(searchResultsController: nil)
    var interactor: SettingsInteractor?
    var presenter: SettingsPresenter?

    override func loadView() {
        super.loadView()
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        presenter = SettingsPresenter(view: self)
        presenter = SettingsPresenter(view: self)
        interactor = SettingsInteractor(presenter: presenter!)
        interactor?.fetchSettings()
    }

    private func setNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func showSettings(_ settings: [[Setting]]) {
        tableView.setSettings(settings)
    }
}
