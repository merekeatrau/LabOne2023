//
//  NestedViewController.swift
//  OneLabHW1
//
//  Created by Mereke on 28.03.2023.
//

import UIKit

class NestedViewController: UIViewController, BottomActionsViewDelegate {
    func didTapPreviousButton() {
        print("tap")
    }

    func didTapNextButton() {
        print("tap")
    }

    func didTapInfoButton() {
        print("tap")
    }

    private let bottomActionsView = BottomActionsView()
    private let ActionsView = BottomActionsView()

    lazy var innerButtons: [UIButton] = [
        createButton(text: "Clear", imageName: nil),
        createButton(text: "Save", imageName: nil),
        createButton(text: "Cancel", imageName: nil)]

    lazy var labels: [UILabel] = [
        createLabel(text: "First"),
        createLabel(text: "Middle"),
        createLabel(text: "Last")]

    lazy var notesTextView = createTextView(text: "Notes")

    lazy var textfields: [UITextField] = [
        createTextField(placeholder: "First"),
        createTextField(placeholder: "Middle"),
        createTextField(placeholder: "Last")]

    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.spacing = 12
        stackview.backgroundColor = .systemGray6
        stackview.layer.cornerRadius = 24
        stackview.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        stackview.isLayoutMarginsRelativeArrangement = true
        return stackview
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "first"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    lazy var labelStackView = createLabelStackView(label: labels)
    lazy var textFieldStackView = createTextFieldStackView(textfields: textfields)
    lazy var innerButtonStackView = createButtonStackview(buttons: innerButtons)

    private let labelTextFieldStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 16
        return stackview
    }()

    private let imageTFStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 16
        return stackview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Nested Stack View"
        bottomActionsView.delegate = self
        setupSubviews()
        setConstraints()
    }

    private func setupSubviews() {

        view.addSubview(bottomActionsView)
        view.addSubview(stackView)

        for innterButton in innerButtons {
            innerButtonStackView.addArrangedSubview(innterButton)
        }

        labelTextFieldStackView.addArrangedSubview(labelStackView)
        labelTextFieldStackView.addArrangedSubview(textFieldStackView)

        imageTFStackView.addArrangedSubview(imageView)
        imageTFStackView.addArrangedSubview(labelTextFieldStackView)

        stackView.addArrangedSubview(imageTFStackView)
        stackView.addArrangedSubview(notesTextView)
        stackView.addArrangedSubview(innerButtonStackView)

    }

    private func setConstraints() {
        
        labelTextFieldStackView.snp.makeConstraints() {
            $0.top.equalTo(imageTFStackView.snp.top).offset(8)
            $0.bottom.equalTo(imageTFStackView.snp.bottom).offset(-8)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.right.equalToSuperview().inset(24)
        }

        notesTextView.snp.makeConstraints() {
            $0.height.greaterThanOrEqualTo(360)
            $0.left.right.equalTo(stackView).inset(24)
        }

        imageView.snp.makeConstraints() {
            $0.size.equalTo(100)
        }

        bottomActionsView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(36)
            $0.trailing.bottom.equalToSuperview().offset(-36)
            $0.top.equalTo(stackView.snp.bottom).offset(24)
        }
    }
}

extension NestedViewController {
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

    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.text = text
        label.textAlignment = .left
        return label
    }

    private func createLabelStackView(label: [UILabel]) -> UIStackView {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .equalSpacing
        for label in labels {
            stackview.addArrangedSubview(label)
        }
        return stackview
    }

    private func createTextView(text: String) -> UITextView {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .black
        textView.text = text
        textView.textAlignment = .left
        textView.layer.cornerRadius = 12
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.5)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0)
        return textView
    }

    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Enter \(placeholder) Name"
        return textField
    }

    private func createTextFieldStackView(textfields: [UITextField]) -> UIStackView {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .equalSpacing
        for textfield in textfields {
            stackview.addArrangedSubview(textfield)
        }
        return stackview
    }

}
