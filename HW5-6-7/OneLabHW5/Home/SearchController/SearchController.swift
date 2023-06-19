//
//  SearchController.swift
//  OneLabHW5
//
//  Created by Mereke on 13.04.2023.
//

import Foundation
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
