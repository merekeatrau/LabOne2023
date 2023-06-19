//
//  SettingsTableView.swift
//  SettingsMVVM
//
//  Created by Mereke on 08.04.2023.
//

import UIKit
import SnapKit

class SettingsTableView: UIView {

    var settings: [[Setting]] = [[]] {
        didSet {
            tableView.reloadData()
        }
    }

    lazy private var tableView = UITableView(frame: .zero, style: .grouped)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = .white
        tableView.register(SettingTableCell.self, forCellReuseIdentifier: SettingTableCell.identifier)
        addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setSettings(_ settings: [[Setting]]) {
        self.settings = settings
    }
}

extension SettingsTableView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableCell.identifier, for: indexPath) as! SettingTableCell
        cell.configure(settings: settings[indexPath.section][indexPath.row])
        return cell
    }
}
