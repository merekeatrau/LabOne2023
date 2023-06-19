//
//  AddViewController.swift
//  OneLabHW5
//
//  Created by Mereke on 14.04.2023.
//

import UIKit
import SnapKit

class AddViewController: UIViewController {

    private var isEdit: Bool
    private var book: Book!

    init(isEdit: Bool) {
        self.isEdit = isEdit
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "title"
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftView = leftView
        textField.leftViewMode = .always
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()

    private let authorTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "author"
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftView = leftView
        textField.leftViewMode = .always
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()

    private let typeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "book type"
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftView = leftView
        textField.leftViewMode = .always
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()

    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        textView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        textView.layer.borderWidth = 1
        textView.returnKeyType = .done
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) // Add inset
        return textView
    }()

    private let attachmentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.setTitle("  attach photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .black
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        button.layer.borderWidth = 1.0
        return button
    }()

    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("submit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .white
        button.backgroundColor = .black
        return button
    }()

    private let bookTypes = ["Fiction", "Non-Fiction", "Mystery", "Thriller", "Romance", "Science Fiction", "Fantasy", "Horror", "Biography", "History", "Memoir", "Self-Help", "Business", "Cooking", "Travel", "Art", "Religion", "Philosophy", "Poetry"]

    private let bookTypePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    private var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
    }

    private func configureUI() {
        view.backgroundColor = .white
        title = "add book"

        view.addSubview(titleTextField)
        view.addSubview(authorTextField)
        view.addSubview(typeTextField)
        view.addSubview(messageTextView)
        view.addSubview(submitButton)
        view.addSubview(attachmentButton)

        bookTypePickerView.delegate = self
        bookTypePickerView.dataSource = self
        typeTextField.inputView = bookTypePickerView

        attachmentButton.addTarget(self, action: #selector(attachmentButtonTapped), for: .touchUpInside)

        if !isEdit {
            submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        }
        else {
            submitButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        }
    }

    private func setConstraints() {
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(48)
        }

        authorTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(48)
        }

        typeTextField.snp.makeConstraints {
            $0.top.equalTo(authorTextField.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(48)
        }

        messageTextView.snp.makeConstraints {
            $0.top.equalTo(typeTextField.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(attachmentButton.snp.top).offset(-16)
        }

        attachmentButton.snp.makeConstraints {
            $0.top.equalTo(messageTextView.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(48)
        }

        submitButton.snp.makeConstraints {
            $0.top.equalTo(attachmentButton.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalToSuperview().offset(-48)
            $0.height.equalTo(48)
        }
    }

    @objc private func attachmentButtonTapped() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }

    @objc private func submitButtonTapped() {
        saveBook()
        navigationController?.popViewController(animated: true)
    }

    @objc private func editButtonTapped() {
        editBook()
        navigationController?.popViewController(animated: true)
    }

    func setBook(_ book: Book) {
        titleTextField.text = book.title
        authorTextField.text = book.author
        typeTextField.placeholder = book.type
        messageTextView.text = book.overview
        self.book = book
    }
}


extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bookTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bookTypes[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextField.text = bookTypes[row]
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            attachmentButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            attachmentButton.setTitle("  photo attached", for: .normal)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            attachmentButton.setImage(originalImage, for: .normal)
            attachmentButton.setTitle(nil, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    private func saveBook() {
        var imageData: Data? = nil
        if let image = selectedImage {
            imageData = image.pngData()
        }
        CoreDataManager.shared.saveBook(
            title: titleTextField.text!,
            author: authorTextField.text!,
            type: typeTextField.text!,
            overview: messageTextView.text,
            image: imageData
        )
    }

    private func editBook() {
        var imageData: Data? = nil
        if let image = selectedImage {
            imageData = image.pngData()
        }
        CoreDataManager.shared.updateBook(
            book!,
            with: titleTextField.text!,
            newAuthor: authorTextField.text!,
            newType: typeTextField.text!,
            newOverview: messageTextView.text,
            newImage: imageData
        )
    }
}
