//
//  ViewController.swift
//  SettingsMVC
//
//  Created by Mereke on 07.04.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    private let tableView = SettingsTableView()
    private let setting = Setting()
    private let searchController = SearchController(searchResultsController: nil)

    override func loadView() {
        super.loadView()
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setSettings(setting.getSettings())
        setNavBar()
    }

    private func setNavBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}




