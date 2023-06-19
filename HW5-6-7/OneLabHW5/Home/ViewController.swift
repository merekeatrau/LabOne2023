//
//  ViewController.swift
//  OneLabHW5
//
//  Created by Mereke on 13.04.2023.
//

import UIKit

class ViewController: UIViewController {

    private let tableView = BooksTableView()

    private var books = [Book]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchBooks()
        UIView.animate(withDuration: 0.3, delay: 0.3) { [unowned self] in
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "books"
        view.backgroundColor = .white
        setNavBar()
        setTableView()
    }

    private func setTableView() {
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setNavBar() {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }

    @objc func plusButtonTapped() {
        navigationController?.pushViewController(AddViewController(isEdit: false), animated: true)
    }
}

extension ViewController: BooksTableViewDelegate {
    func didEditSwiped(_ index: Int) {
        let editVC = AddViewController(isEdit: true)
        editVC.setBook(books[index])
        navigationController?.pushViewController(editVC, animated: true)
    }

    func didSelectRow(_ index: Int) {
        let detailsVC = DetailsViewController()
        detailsVC.setBook(books[index])
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    private func fetchBooks() {
        books = CoreDataManager.shared.fetchBooks()
        tableView.setBooks(books)
    }
}

