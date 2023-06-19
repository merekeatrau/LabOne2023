//
//  BottomActionButton.swift
//  OneLabHW1
//
//  Created by Mereke on 29.03.2023.
//

import UIKit

class BottomActionButton: UIButton {
    enum ButtonStyle {
        case title(text: String)
        case icon(image: UIImage?)
    }

    private let buttonStyle: ButtonStyle

    init(buttonStyle: ButtonStyle) {
        self.buttonStyle = buttonStyle
        super.init(frame: CGRect(x: 0, y: 0, width: 96, height: 24))
        
        configureButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureButton() {
        switch buttonStyle {
        case let .title(text):
            setTitle(text, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 14)
            setTitleColor(.systemBlue, for: .normal)
        case let .icon(image):
            setImage(image, for: .normal)
        }
    }
}
