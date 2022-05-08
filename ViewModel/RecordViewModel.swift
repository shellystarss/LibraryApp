//
//  RecordViewModel.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import Foundation
import CoreData

class RecordViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.viewContext
    @Published var record: Record = Record()
    @Published var records: [Record] = []
    @Published var selectedRecord: Record?
    
    func fetchAll(){
        self.records = PersistenceController.shared.getAllRecords()
    }
    
    func addRecord(bookID: UUID, name: String, selectedBook: Book){
        let newRecord = Record(context: viewContext)
        newRecord.id = UUID()
        selectedBook.recordID = newRecord.id
        newRecord.bookID = bookID
        newRecord.borrowerName = name
        let borrowDate = Date()
        newRecord.borrowDate = borrowDate
        newRecord.returnDate = borrowDate.getReturnDate(borrowDate: borrowDate)
        selectedBook.isBorrowed = true
        save()
    }
    
    func selectRecord(record: Record) {
        self.selectedRecord = record
    }
    
    func getSelectedRecord(id: UUID) {
        self.selectedRecord = PersistenceController.shared.getSelectedRecord(id: id)
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
    
    func updateRecord(name: String, borrowDate: Date, selectedRecord: Record) {
        
        selectedRecord.borrowerName = name
        selectedRecord.borrowDate = borrowDate
        let currentDate = borrowDate
        var dateComponent = DateComponents()
        dateComponent.day = 7
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        selectedRecord.returnDate = futureDate
        save()
    }
    
    func delete<T>(_ objectToDelete: T) where T: NSManagedObject {
        let existingRecord = PersistenceController.shared.getRecordById(id: objectToDelete.objectID)
        if let existingRecord = existingRecord {
            PersistenceController.shared.deleteRecord(record: existingRecord)
        }
    }
    
    func save() {
        PersistenceController.shared.save()
    }
}
