//
//  Note.swift
//  OneLabHW3
//
//  Created by Mereke on 04.04.2023.
//

import Foundation

struct Notes: Codable {
    let notes: [Note]
}

struct Note: Codable {
    let id: String
    let title: String
    let description: String?
}

extension Note {
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = ["id": id, "title": title]
        if let description = description {
            dictionary["description"] = description
        }
        return dictionary
    }
}
