//
//  SettingsDataDisplayManager.swift
//  SettingsMVC
//
//  Created by Mereke on 07.04.2023.
//

import Foundation
import UIKit

final class DataDisplayManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    var settings: [[Setting]] = [[]]

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
