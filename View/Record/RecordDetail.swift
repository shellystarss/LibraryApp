//
//  RecordDetail.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import SwiftUI

struct RecordDetail: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest( sortDescriptors: [SortDescriptor(\.title)]) var books: FetchedResults<Book>
    @State var selectedRecord: Record
    @State var name: String = ""
    @State var borrowDate: Date = Date()
    @State var returnDate: Date = Date()
    
    func getBookInfo(bookID: UUID) -> Book {
        for book in books {
            if book.id == bookID {
                return book
            }
        }
        return Book()
    }
    var body: some View {
        VStack {
            Form {
                Section(header: Text("User info")) {
                    
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Borrower name", text: $name)
                            .onAppear{
                                self.name = selectedRecord.borrowerName!
                            }
                    }
                    HStack {
                        Text("Borrow date")
                        Spacer()
                        DatePicker(selection: $borrowDate, in: ...Date(), displayedComponents: .date) {
                                        Text("")
                                    }
                            .onAppear{
                                self.borrowDate = selectedRecord.borrowDate!
                            }
                    }
                    
                    HStack {
                        Text("Return date")
                        Spacer()
                        Text(selectedRecord.returnDate!, style: .date)
                       
                    }
                }
                
                Section {
                    Button("Save changes") {
                        if (!name.isEmpty ) {
                            
                            selectedRecord.borrowerName = name
                            selectedRecord.borrowDate = borrowDate
                            let currentDate = borrowDate
                            var dateComponent = DateComponents()
                            dateComponent.day = 7
                            let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
                            
                            selectedRecord.returnDate = futureDate
                            try? moc.save()
                            self.presentationMode.wrappedValue.dismiss()
                            // dismiss()
                        }
                    }
                }
                
                Section(header: Text("Book info")){
                    let book = getBookInfo(bookID: selectedRecord.bookID!)
                    HStack {
                        Image(uiImage: UIImage(data: book.image!)!)
                            .resizable().frame(width: 100, height: 100, alignment: .leading)
                        VStack(alignment: .leading) {
                            Text("\(book.title!) (\(book.year!))")
                                .bold()
                            Text("by \(book.author!)")
                            Text("\(book.category!) book").foregroundColor(.gray)
                        }
                        
                    }
                }
                
                Section {
                    let book = getBookInfo(bookID: selectedRecord.bookID!)
                    if book.isBorrowed && (book.id == selectedRecord.bookID) {
                        Button("Return") {
                            
                                book.isBorrowed = false
                                
                                try? moc.save()
                                self.presentationMode.wrappedValue.dismiss()
                                // dismiss()
                            
                        }.foregroundColor(.red)
                    }
                    
                }
                
                
            }
        }.navigationTitle("Record detail")
    }
}
