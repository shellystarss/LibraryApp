//
//  BookDetail.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import SwiftUI

struct BookDetail: View {
    @StateObject var recordVM = RecordViewModel()
    @StateObject var bookVM = BookViewModel()
    @State var selectedBook: Book
    //form
    @State var name: String = ""
    @State var showingAlert: Bool = false
    @State var bookRecord : [Record] = []
    
    func resetForm(){
        name = ""
    }
    
    var body: some View {
        VStack{
            Image(uiImage: UIImage(data: selectedBook.image!)!)
                .resizable().frame(width: 200, height: 200, alignment: .leading)
            List {
                Section(header: Text("Info")){
                    DetailView(text: "Author", detail: selectedBook.author!)
                    DetailView(text: "Release year", detail: selectedBook.year!)
                    DetailView(text: "Category", detail: selectedBook.category!)
                }
                
                if(selectedBook.isBorrowed){
                    Section(header: Text("This book is borrowed")){
                        DetailView(text: "Current borrower", detail: recordVM.getBorrowerName(selectedBook: selectedBook))
                        DetailView(text: "Borrow date", detail: recordVM.getIssuedDate(selectedBook: selectedBook))
                        DetailView(text: "Return date", detail: recordVM.getReturnDate(selectedBook: selectedBook))
                    }
                }else{
                    Section(header: Text("Fill form to borrow")){
                        TextField("Borrower name", text: $name)
                    
                        Text("Borrow this book").foregroundColor(.blue).onTapGesture {
                            
                            if (!name.isEmpty) {
                                recordVM.addRecord(bookID: selectedBook.id!, name: name, selectedBook: selectedBook)
                                recordVM.fetchAll()
                                showingAlert = true
                                resetForm()
                                // dismiss()
                            }
                            
                        }.alert("Borrow success", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
                        }
                        
                    }
                }
                
            }
        }
        
        .navigationTitle(selectedBook.title!)
        .onAppear{
            recordVM.fetchAll()
        }
        
    }
}

struct DetailView: View{
    @State var text: String
    @State var detail: String
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Text(detail).foregroundColor(.gray)
        }
    }
}
