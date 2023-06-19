//
//  ViewController.swift
//  OneLabHW3
//
//  Created by Mereke on 04.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let notesTableView = UITableView()

    private var notes: [Note] = []

    private var networkManager = NetworkManager.shared

    private let searchController: UISearchController = {
        let searchcontroller = UISearchController(searchResultsController: nil)
        searchcontroller.obscuresBackgroundDuringPresentation = false
        searchcontroller.searchBar.placeholder = "Search"
        return searchcontroller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadNotes()
        setupUI()
    }

    private func setupUI() {
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        view.addSubview(notesTableView)
        notesTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.rowHeight = UITableView.automaticDimension
        notesTableView.estimatedRowHeight = 64
        notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoteCell")

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let noteDetailsViewController = DetailsViewController()
        noteDetailsViewController.noteTextView.text = notes[indexPath.row].description
        noteDetailsViewController.title = notes[indexPath.row].title
        navigationController?.pushViewController(noteDetailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = notes[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            self?.deleteNote(note, indexPath: indexPath)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = notes[indexPath.row]
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            let alertController = UIAlertController(title: "Edit Note", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.text = note.title
            }
            alertController.addTextField { (textField) in
                textField.text = note.description
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
                completion(false)
            }
            let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
                guard let newTitle = alertController.textFields?[0].text, !newTitle.isEmpty else {
                    completion(false)
                    return
                }
                let newDescription = alertController.textFields?[1].text
                self.updateNote(note, indexPath: indexPath, newTitle: newTitle, newDescription: newDescription)
                completion(true)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            self.present(alertController, animated: true, completion: nil)
        }
        return UISwipeActionsConfiguration(actions: [editAction])
    }
}

extension ViewController {

    @objc private func addNote() {
        let alertController = UIAlertController(title: "New Note", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Title"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Description (optional)"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            guard let title = alertController.textFields?.first?.text,
                  !title.isEmpty else { return }
            let description = alertController.textFields?.last?.text
            let note = Note(id: "", title: title, description: description)
            NetworkManager.shared.addNote(note) { result in
                switch result {
                case .success(let note):
                    self.notes.append(note)
                    self.notesTableView.reloadData()
                case .failure(let error):
                    print("Error adding note: \(error)")
                }
            }
        }))
        present(alertController, animated: true, completion: nil)
    }

    private func loadNotes() {
        networkManager.fetchNotes { result in
            switch result {
            case .success(let notes):
                self.notes = notes
                self.notesTableView.reloadData()
            case .failure(let error):
                print("Error fetching notes: \(error)")
            }
        }
    }

    func deleteNote(_ note: Note, indexPath: IndexPath) {
        NetworkManager.shared.deleteNote(note) { result in
            switch result {
            case .success:
                self.notes.remove(at: indexPath.row)
                self.notesTableView.reloadData()
            case .failure(let error):
                print("Error deleting note: \(error.localizedDescription)")
            }
        }
    }

    func updateNote(_ note: Note, indexPath: IndexPath, newTitle: String, newDescription: String?) {
        let updatedNote = Note(id: note.id, title: newTitle, description: newDescription)
        NetworkManager.shared.updateNote(updatedNote) { result in
            switch result {
            case .success:
                self.notes[indexPath.row] = updatedNote
                self.notesTableView.reloadRows(at: [indexPath], with: .automatic)
            case .failure(let error):
                print("Error updating note: \(error.localizedDescription)")
            }
        }
    }
}


