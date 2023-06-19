//
//  RestaurantTableView.swift
//  OneLabHW5
//
//  Created by Mereke on 13.04.2023.
//

import UIKit
import SnapKit

protocol BooksTableViewDelegate: AnyObject {
    func didSelectRow(_ index: Int)
    func didEditSwiped(_ index: Int)
}

class BooksTableView: UIView {

    lazy private var tableView = UITableView(frame: .zero, style: .grouped)

    weak var delegate: BooksTableViewDelegate?

    private var books: [Book] = []{
        didSet {
            tableView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 180

        tableView.backgroundColor = .clear
        tableView.register(BooksTableHeaderView.self, forHeaderFooterViewReuseIdentifier: BooksTableHeaderView.reuseIdentifier)
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setBooks(_ books: [Book]) {
        self.books = books
    }

    func reloadData() {
        tableView.reloadData()
    }
}

extension BooksTableView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as! BookTableViewCell
        cell.configure(books[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(indexPath.row)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            guard let self = self else { return }

            let bookToDelete = self.books[indexPath.row]
            CoreDataManager.shared.deleteBook(bookToDelete)
            self.books.remove(at: indexPath.row)
            tableView.reloadData()
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            self.delegate?.didEditSwiped(indexPath.row)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [editAction])
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BooksTableHeaderView.reuseIdentifier) as? BooksTableHeaderView else {
            return nil
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
}
