//
//  BookViewModel.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import Foundation

class BookViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.viewContext
    @Published var book: Book = Book()
    @Published var books: [Book] = []
    @Published var selectedBook: Book?
    
    func fetchAll(){
        self.books = PersistenceController.shared.getAllBooks()
    }
    
    func selectBook(book: Book){
        self.selectedBook = book
    }
    
    func addBook(title: String, author: String, year: String, category: String, image: Data) {
        let newBook = Book(context: viewContext)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.year = year
        newBook.category = category
        newBook.isBorrowed = false
        newBook.image = image
        save()
        
    }
    
    func save() {
        PersistenceController.shared.save()
    }
}
