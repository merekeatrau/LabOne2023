//
//  ViewController.swift
//  Settings
//
//  Created by Mereke on 08.04.2023.
//

import UIKit
import SnapKit

protocol SettingsViewProtocol: AnyObject {
    func setSettings(_ settings: [[Setting]])
}

class SettingsViewController: UIViewController {

    private let tableView = SettingsTableView()
    private let setting = Setting()
    private let searchController = SearchController(searchResultsController: nil)

    var presenter: SettingsPresenter?

    override func loadView() {
        super.loadView()
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        presenter = SettingsPresenter(view: self)
        presenter?.setSettings()
    }

    private func setNavBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func setSettings(_ settings: [[Setting]]) {
        tableView.setSettings(settings)
    }
}


