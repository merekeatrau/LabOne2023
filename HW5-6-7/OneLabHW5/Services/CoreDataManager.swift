//
//  CoreDataManager.swift
//  OneLabHW5
//
//  Created by Mereke on 15.04.2023.
//

import UIKit
import CoreData

struct Book {
    let title: String
    let author: String
    let type: String
    let overview: String?
    let image: UIImage?
}

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OneLabHW5")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveBook(title: String, author: String, type: String, overview: String?, image: Data?) {
        let context = persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "BookEntity", in: context)!
        let bookManagedObject = NSManagedObject(entity: entity, insertInto: context)

        bookManagedObject.setValue(title, forKey: "title")
        bookManagedObject.setValue(author, forKey: "author")
        bookManagedObject.setValue(type, forKey: "type")
        bookManagedObject.setValue(overview, forKey: "overview")

        if let imageData = image, let uiImage = UIImage(data: imageData) {
            bookManagedObject.setValue(uiImage, forKey: "image")
        }

        do {
            try context.save()
            print("Book saved!")
        } catch let error as NSError {
            print("Could not save book. \(error), \(error.userInfo)")
        }
    }

    func fetchBooks() -> [Book] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")

        do {
            let result = try context.fetch(fetchRequest)
            var books = [Book]()

            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as! String
                let author = data.value(forKey: "author") as! String
                let type = data.value(forKey: "type") as! String
                let overview = data.value(forKey: "overview") as? String
                let image = data.value(forKey: "image") as? UIImage

                let book = Book(title: title, author: author, type: type, overview: overview, image: image)
                books.append(book)
            }

            return books
        } catch let error as NSError {
            print("Could not fetch books. \(error), \(error.userInfo)")
            return []
        }
    }

    func deleteBook(_ book: Book) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")
        fetchRequest.predicate = NSPredicate(format: "title = %@", book.title)

        do {
            let result = try context.fetch(fetchRequest)
            guard let bookToDelete = result.first as? NSManagedObject else { return }
            context.delete(bookToDelete)
            try context.save()
            print("Book deleted!")
        } catch let error as NSError {
            print("Could not delete book. \(error), \(error.userInfo)")
        }
    }

    func updateBook(_ book: Book, with newTitle: String, newAuthor: String, newType: String, newOverview: String?, newImage: Data?) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")
        fetchRequest.predicate = NSPredicate(format: "title = %@", book.title)

        do {
            let result = try context.fetch(fetchRequest)
            guard let bookToUpdate = result.first as? NSManagedObject else { return }
            bookToUpdate.setValue(newTitle, forKey: "title")
            bookToUpdate.setValue(newAuthor, forKey: "author")
            bookToUpdate.setValue(newType, forKey: "type")
            bookToUpdate.setValue(newOverview, forKey: "overview")
            if let imageData = newImage, let uiImage = UIImage(data: imageData) {
                bookToUpdate.setValue(uiImage, forKey: "image")
            }
            try context.save()
            print("Book updated!")
        } catch let error as NSError {
            print("Could not update book. \(error), \(error.userInfo)")
        }
    }
}


