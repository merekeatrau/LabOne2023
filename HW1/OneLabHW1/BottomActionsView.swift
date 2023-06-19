//
//  BottomActionsView.swift
//  OneLabHW1
//
//  Created by Mereke on 29.03.2023.
//

import UIKit

protocol BottomActionsViewDelegate: AnyObject {
    func didTapPreviousButton()
    func didTapNextButton()
    func didTapInfoButton()
}

class BottomActionsView: UIView {

    weak var delegate: BottomActionsViewDelegate?

    private let previousButton = BottomActionButton(buttonStyle: .title(text: "Previous"))
    private let infoButton = BottomActionButton(buttonStyle: .icon(image: UIImage(systemName: "info.circle")))
    private let nextButton = BottomActionButton(buttonStyle: .title(text: "Next"))
    private let horizontalStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .equalCentering
        horizontalStackView.spacing = 8
        addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        horizontalStackView.addArrangedSubview(previousButton)
        horizontalStackView.addArrangedSubview(infoButton)
        horizontalStackView.addArrangedSubview(nextButton)

    }

    private func configureViews() {
        previousButton.addTarget(self, action: #selector(handlePreviousButtonAction), for: .touchUpInside)
    }

    @objc private func handlePreviousButtonAction() {
        delegate?.didTapPreviousButton()
    }
}
