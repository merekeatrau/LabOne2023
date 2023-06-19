//
//  ViewController.swift
//  Contacts
//
//  Created by Mereke on 01.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let searchController: UISearchController = {
        let searchcontroller = UISearchController(searchResultsController: nil)
        searchcontroller.obscuresBackgroundDuringPresentation = false
        searchcontroller.searchBar.placeholder = "Search"
        return searchcontroller
    }()

    var names = [
        "Akhmetov", "Zhakupova", "Zhumabekova",
        "Kenzhebayeva", "Kozybayeva", "Suleimenova", "Sultanbekova", "Tleulina",
        "Aldiyar", "Arman", "Assel", "Azamat", "Bakyt", "Damir",
        "Dana", "Danel", "Dariya", "Daulet", "Diana",
        "Dinara", "Erkebulan", "Erken", "Gulmira", "Kairat",
        "Kamila", "Karlygash", "Kassym", "Madina", "Madiyar",
        "Magzhan", "Makhambet", "Nurlybek", "Nursultan", "Sanzhar",
        "Sarsenbay", "Saya", "Symbat", "Temirlan", "Yerkebulan"
    ].sorted()

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setNavBar()
        setTableView()
    }

    private func setNavBar() {
        title = "All contacts"

        navigationController?.navigationBar.prefersLargeTitles = true

        let userButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addContact))
        navigationItem.rightBarButtonItem = userButton
        userButton.tintColor = .systemBlue

        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .systemBlue

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }


    @objc private func addContact() {
        let alertController = UIAlertController(title: "Add Contact", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let name = alertController.textFields?.first?.text {
                self.names.append(name)
                self.tableView.reloadData()
            }
        }
        alertController.addAction(addAction)

        present(alertController, animated: true, completion: nil)
    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letter = Character(UnicodeScalar(section + 65)!)
        return names.filter { $0.first == letter }.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let letter = Character(UnicodeScalar(indexPath.section + 65)!)
        let filteredNames = names.filter { $0.first == letter }
        cell.textLabel?.text = filteredNames[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let letter = Character(UnicodeScalar(section + 65)!)
        return names.first { $0.first == letter }.map { _ in
            String(letter)
        }
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return (0..<26).compactMap { index in
            let letter = Character(UnicodeScalar(index + 65)!)
            return names.first { $0.first == letter }.map { _ in
                String(letter)
            }
        }
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return names.firstIndex { $0.hasPrefix(title) } ?? 0
    }
}





