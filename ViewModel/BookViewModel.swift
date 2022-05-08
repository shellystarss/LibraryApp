//
//  BookViewModel.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import Foundation

class BookViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.viewContext
    
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
    
    func getBookTitle(bookID: UUID) -> String {
        for book in self.books {
            if book.id == bookID{
                return book.title!
            }
        }
        return ""
    }
    
    func getBookInfo(bookID: UUID, recordID: UUID) -> Book {
        for book in self.books {
            if book.id == bookID && book.recordID == recordID {
                return book
            } else if book.id == bookID {
                return book
            }
        }
        return Book()
    }
    
    func returnBook(book: Book){
        book.isBorrowed = false
        save()
    }
    
    func changeBookStatus(bookID: UUID) {
        for book in self.books {
            if book.id == bookID {
                book.isBorrowed = false
                save()
            }
        }
    }
    
    func save() {
        PersistenceController.shared.save()
    }
}
