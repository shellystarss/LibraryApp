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
    
    var body: some View {
        NavigationView {
            VStack {
                if recordVM.records.isEmpty {
                    Text("No record")
                } else {
                    List{
                        ForEach(recordVM.records, id: \.self){ record in
                            NavigationLink(destination: RecordDetail(selectedRecord: record, book: bookVM.getBookInfo(bookID: record.bookID!, recordID: record.id!)).simultaneousGesture(TapGesture().onEnded {
                                recordVM.selectRecord(record: record)
                            })
                            ) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(record.borrowerName!)
                                        Text(" - ")
                                        Text(bookVM.getBookTitle(bookID: record.bookID!))
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
            
        }
        .onAppear{
            bookVM.fetchAll()
            recordVM.fetchAll()
        }
        
    }
    
    func deleteRecord(at offsets: IndexSet) {
        offsets.forEach { index in
            let record = recordVM.records[index]
            bookVM.changeBookStatus(bookID: record.bookID!)
            recordVM.delete(record)
        }
        recordVM.fetchAll()
    }
}
