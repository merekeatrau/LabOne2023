//
//  Book.swift
//  OneLabHW5
//
//  Created by Mereke on 15.04.2023.
//

import Foundation
import UIKit

struct BookBuilder {
    private var title: String = ""
    private var author: String = ""
    private var type: String = ""
    private var overview: String? = nil
    private var image: UIImage? = nil

    mutating func setTitle(_ title: String) {
        self.title = title
    }

    mutating func setAuthor(_ author: String) {
        self.author = author
    }

    mutating func setType(_ type: String) {
        self.type = type
    }

    mutating func setOverview(_ overview: String?) {
        self.overview = overview
    }

    mutating func setImage(_ image: UIImage?) {
        self.image = image
    }

    func build() -> Book {
        return Book(title: title, author: author, type: type, overview: overview, image: image)
    }

    func getTitle() -> String {
        return title
    }

    func getAuthor() -> String {
        return author
    }

    func getType() -> String {
        return type
    }

    func getOverview() -> String? {
        return overview
    }

    func getImage() -> UIImage? {
        return image
    }
}


