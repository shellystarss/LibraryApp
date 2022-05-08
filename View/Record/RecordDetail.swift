//
//  RecordDetail.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import SwiftUI

struct RecordDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var bookVM = BookViewModel()
    @StateObject var recordVM = RecordViewModel()
    @State var selectedRecord: Record
    @State var book: Book
    @State var name: String = ""
    @State var borrowDate: Date = Date()
    @State var returnDate: Date = Date()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("User info")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Borrower name", text: $name)
                            .onAppear{
                                self.name = recordVM.selectedRecord!.borrowerName!
                            }
                    }
                    HStack {
                        Text("Borrow date")
                        Spacer()
                        DatePicker(selection: $borrowDate, in: ...Date(), displayedComponents: .date) {
                            Text("")
                        }
                        .onAppear{
                            self.borrowDate = recordVM.selectedRecord!.borrowDate!
                        }
                        
                    }
                    
                    HStack {
                        Text("Return date")
                        Spacer()
                        
                        Text(borrowDate.getReturnDate(borrowDate: borrowDate), style: .date)
                    }
                }
                
                Section {
                    Text("Save changes").foregroundColor(.blue).onTapGesture {
                        if (!name.isEmpty ) {
                            recordVM.updateRecord(name: name, borrowDate: borrowDate, selectedRecord: recordVM.selectedRecord!)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
                Section(header: Text("Book info")){
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
                    
                    if book.isBorrowed && (book.id == selectedRecord.bookID) {
                        Text("Return").foregroundColor(.red).onTapGesture {
                            bookVM.returnBook(book: book)
                            self.presentationMode.wrappedValue.dismiss()
                        }.foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Record detail")
            .onAppear{
                bookVM.fetchAll()
                recordVM.fetchAll()
                recordVM.getSelectedRecord(id: selectedRecord.id!)
                
                book = bookVM.getBookInfo(bookID: selectedRecord.bookID!, recordID: selectedRecord.id!)
            }
        }
    }
}
