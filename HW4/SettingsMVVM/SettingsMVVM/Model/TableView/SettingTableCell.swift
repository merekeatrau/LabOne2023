//
//  SettingTableCell.swift
//  SettingsMVVM
//
//  Created by Mereke on 08.04.2023.
//

import UIKit
import SnapKit

class SettingTableCell: UITableViewCell {

    static let identifier = "SettingTableCell"

    private let iconContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()

    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .white
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private let toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = false
        return toggleSwitch
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setConstraints()

    }

    private func setupUI() {
        contentView.backgroundColor = .clear

        contentView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(toggleSwitch)
    }

    private func setConstraints() {
        iconContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(32)
        }

        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconContainerView.snp.trailing).offset(16)
        }

        toggleSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-24)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(settings: Setting) {
        titleLabel.text = settings.title
        iconImageView.image = settings.icon
        iconContainerView.backgroundColor = settings.color
        toggleSwitch.isHidden = !settings.hasToggle
        toggleSwitch.isOn = settings.isToggleOn
        accessoryType = settings.hasDisclosureIndicator ? .disclosureIndicator : .none
    }
}
