//
//  BooksTableHeader.swift
//  OneLabHW5
//
//  Created by Mereke on 16.04.2023.
//

import UIKit
import SnapKit

class BooksTableHeaderView: UITableViewHeaderFooterView {

    static let reuseIdentifier = "BooksTableHeaderView"

    private let segmentedControl: UISegmentedControl

    override init(reuseIdentifier: String?) {
        segmentedControl = UISegmentedControl(items: ["All", "Favorites"])
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(segmentedControl)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        segmentedControl.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func segmentedControlValueChanged() {

    }
}
