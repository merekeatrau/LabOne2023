//
//  NetworkManager.swift
//  OneLabHW3
//
//  Created by Mereke on 04.04.2023.
//

import Foundation
import Alamofire
import FirebaseDatabase
import FirebaseStorage
import UIKit

class NetworkManager {

    static var shared = NetworkManager()

    let notesRef = Database.database().reference(withPath: "notes")

    private let storageRef = Storage.storage().reference()

    func fetchNotes(completion: @escaping (Result<[Note], Error>) -> Void) {
        notesRef.observeSingleEvent(of: .value) { snapshot in
            var notes: [Note] = []
            for child in snapshot.children {
                if let noteSnapshot = child as? DataSnapshot, let noteDict = noteSnapshot.value as? [String: Any] {
                    let note = Note(id: noteSnapshot.key, title: noteDict["title"] as? String ?? "", description: noteDict["description"] as? String)
                    notes.append(note)
                }
            }
            completion(.success(notes))
        } withCancel: { error in
            completion(.failure(error))
        }
    }

    func addNote(_ note: Note, completion: @escaping (Result<Note, Error>) -> Void) {
        let noteRef = notesRef.childByAutoId()
        let noteDict = ["title": note.title, "description": note.description ?? ""]
        noteRef.setValue(noteDict) { error, ref in
            if let error = error {
                completion(.failure(error))
            } else {
                let newNote = Note(id: ref.key ?? "", title: note.title, description: note.description)
                completion(.success(newNote))
            }
        }
    }

    func deleteNote(_ note: Note, completion: @escaping (Result<Void, Error>) -> Void) {
        let noteRef = notesRef.child(note.id)
        noteRef.removeValue { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func updateNote(_ note: Note, completion: @escaping (Result<Void, Error>) -> Void) {
        let noteRef = notesRef.child(note.id)
        let values = note.toDictionary()
        noteRef.updateChildValues(values) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func downloadImage(withPath path: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imageRef = storageRef.child(path)
        imageRef.getData(maxSize: 1 * 2048 * 2048) { data, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                let error = NSError(domain: "com.yourapp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to download image"])
                completion(.failure(error))
            }
        }
    }
}



