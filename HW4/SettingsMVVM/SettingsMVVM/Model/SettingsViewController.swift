//
//  ViewController.swift
//  SettingsMVVM
//
//  Created by Mereke on 08.04.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    private let tableView = SettingsTableView()
    private let setting = Setting()
    private let searchController = SearchController(searchResultsController: nil)

    var viewModel: SettingsViewModel?

    override func loadView() {
        super.loadView()
        view = tableView
        viewModel = SettingsViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        bindViewModel()
        viewModel?.setSettings()
    }

    private func setNavBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func bindViewModel() {
        viewModel?.didShowSettings = { [unowned self] viewModel in
            guard let settings = viewModel.settings else { return }
            self.tableView.setSettings(settings)
        }
    }
}

