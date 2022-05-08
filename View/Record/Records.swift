//
//  Borrow.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import SwiftUI

struct Records: View {
    @StateObject var bookVM = BookViewModel()
    @StateObject var recordVM = RecordViewModel()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Record.borrowDate, ascending: false)]) var records: FetchedResults<Record>
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    func getBookTitle(bookID: UUID) -> String {
        for book in books {
            if book.id == bookID{
                return book.title!
            }
        }
        return ""
    }
    var body: some View {
        NavigationView {
            VStack {
                
                if recordVM.records.isEmpty {
                    Text("No record")
                } else {
                    
                    List{
                        ForEach(recordVM.records, id: \.self){ record in
                            NavigationLink(destination: RecordDetail(selectedRecord: record)) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(record.borrowerName!)
                                        Text(" - ")
                                        Text(getBookTitle(bookID: record.bookID!))
                                    }
                                    HStack {
                                        Text(record.borrowDate!, style: .date)
                                        Text(" - ")
                                        Text(record.returnDate!, style: .date)
                                    }
                                    .foregroundColor(.gray)
                                }
                                
                            }
                        }
                        .onDelete(perform: deleteRecord)
                    }
                }
            }
            .navigationTitle("Borrow Records")
            .toolbar {
                EditButton()
            }
            .onAppear{
                bookVM.fetchAll()
                recordVM.fetchAll()
            }
        }
        
    }
    
    func deleteRecord(at offsets: IndexSet) {
        for index in offsets {
            let record = records[index]
            moc.delete(record)
            changeBookStatus(bookID: record.bookID!)
            try? moc.save()
        }
    }
    
    func changeBookStatus(bookID: UUID) {
        for book in books {
            if book.id == bookID {
                book.isBorrowed = false
                try? moc.save()
            }
        }
    }
}

struct Borrow_Previews: PreviewProvider {
    static var previews: some View {
        Records()
    }
}
