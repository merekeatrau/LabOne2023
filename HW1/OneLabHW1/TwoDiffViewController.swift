//
//  TwoDiffViewController.swift
//  OneLabHW1
//
//  Created by Mereke on 29.03.2023.
//

import UIKit

class TwoDiffViewController: UIViewController {

    lazy var buttons: [UIButton] = [createButton(text: "Previous", imageName: nil),createButton(text: "Next", imageName: "info.circle"),createButton(text: "Next", imageName: nil)]

    lazy var views: [UIView] = [createView(color: .black), createView(color: .systemYellow)]

    lazy var buttonStackView = createButtonStackview(buttons: buttons)

    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 16
        stackview.backgroundColor = .systemGray6
        stackview.layer.cornerRadius = 12
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        stackview.isLayoutMarginsRelativeArrangement = true
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Nested Stack View"
        setupSubviews()
        setConstraints()
    }

    private func setupSubviews() {

        view.addSubview(stackView)
        view.addSubview(buttonStackView)

        for button in buttons {
            buttonStackView.addArrangedSubview(button)
        }

        let firstView = views[0]
        let secondView = views[1]

        stackView.addArrangedSubview(firstView)
        stackView.addArrangedSubview(secondView)

        firstView.snp.makeConstraints {
                $0.width.equalTo(stackView.snp.width).multipliedBy(0.33).offset(-24)
            }

            secondView.snp.makeConstraints {
                $0.width.equalTo(stackView.snp.width).multipliedBy(0.67).offset(-24)
            }

    }

    private func setConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.right.equalToSuperview().inset(24)
        }

        buttonStackView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
            $0.top.equalTo(stackView.snp.bottom).offset(24)
        }
    }
}

extension TwoDiffViewController {
    private func createView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = 12
        return view
    }

    private func createButton(text: String, imageName: String?) -> UIButton {
        let button = UIButton(type: .system)
        if let imageName = imageName {
            let infoImage = UIImage(systemName: imageName)
            button.setImage(infoImage, for: .normal)
        }
        else {
            button.setTitle(text, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(.systemBlue, for: .normal)
        }

        button.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(96)
            $0.height.greaterThanOrEqualTo(24)
        }
        return button
    }

    private func createButtonStackview(buttons: [UIButton]) -> UIStackView {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalCentering
        stackview.spacing = 8
        return stackview
    }
}
