//
//  DetailsViewController.swift
//  OneLabHW3
//
//  Created by Mereke on 04.04.2023.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {

    let networkManager = NetworkManager.shared

    lazy var imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 16
        imageview.clipsToBounds = true
        return imageview
    }()

    var noteTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = false
        textView.layer.cornerRadius = 16
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textView.textContainerInset = insets
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(noteTextView)
        view.addSubview(imageView)

        noteTextView.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(400)
        }

        imageView.snp.makeConstraints {
            $0.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(noteTextView.snp.bottom).offset(16)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editNote))
    }

    @objc private func editNote() {
        noteTextView.isEditable = !noteTextView.isEditable
        navigationItem.rightBarButtonItem?.title = noteTextView.isEditable ? "Save" : "Edit"
    }
}

extension DetailsViewController {
    private func loadImage() {
        networkManager.downloadImage(withPath: "milad.jpg") { result in
            switch result {
            case .success(let image):
                print(image)
                self.imageView.image = image
            case .failure(let error):
                print("Unable to download image: \(error)")
            }
        }
    }
}
