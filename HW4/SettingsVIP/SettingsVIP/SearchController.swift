//
//  SearchController.swift
//  SettingsVIP
//
//  Created by Mereke on 08.04.2023.
//

import UIKit

class SearchController: UISearchController {

    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        setupSearchController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSearchController() {
        obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = "Search"
    }
}
