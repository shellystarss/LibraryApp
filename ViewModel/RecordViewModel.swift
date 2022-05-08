//
//  RecordViewModel.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import Foundation

class RecordViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.viewContext
    @Published var record: Record = Record()
    @Published var records: [Record] = []
    @Published var selectedRecord: [Record] = []
    
    func fetchAll(){
        self.records = PersistenceController.shared.getAllRecords()
    }
    
    func addRecord(bookID: UUID, name: String, selectedBook: Book){
        let newRecord = Record(context: viewContext)
        newRecord.bookID = bookID
        newRecord.borrowerName = name
        let borrowDate = Date()
        newRecord.borrowDate = borrowDate
        newRecord.returnDate = borrowDate.getReturnDate(borrowDate: borrowDate)
        selectedBook.isBorrowed = true
        save()
    }
    
    func getBorrowerName(selectedBook: Book) -> String {
        for record in self.records {
            if record.bookID == selectedBook.id {
                return record.borrowerName!
            }
        }
        return ""
    }
    
    func getIssuedDate(selectedBook: Book) -> String {
        for record in self.records {
            if record.bookID == selectedBook.id {
                return record.borrowDate!.formatted()
            }
        }
        return ""
    }
    
    func getReturnDate(selectedBook: Book) -> String {
        for record in self.records {
            if record.bookID == selectedBook.id {
                return record.returnDate!.formatted()
            }
        }
        return ""
    }
    
    func save() {
        PersistenceController.shared.save()
    }
}
