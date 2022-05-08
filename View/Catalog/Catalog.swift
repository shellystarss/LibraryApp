//
//  Catalog.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import SwiftUI

struct Catalog: View {
    @StateObject var bookVM = BookViewModel()
    @State private var showingAddScreen = false
    var body: some View {
        NavigationView {
            VStack {
                if bookVM.books.isEmpty {
                    Text("No book")
                } else {
                    List{
                        ForEach(bookVM.books, id: \.self){ book in
                            
                            NavigationLink(destination: BookDetail(selectedBook: book)
                                            .simultaneousGesture(TapGesture().onEnded {
                                bookVM.selectBook(book: book)
                            })
                            ) {
                                
                                HStack {
                                    Image(uiImage: UIImage(data: book.image! )!)
                                        .resizable().frame(width: 100, height: 100, alignment: .leading)
                                    VStack(alignment: .leading) {
                                        Text("\(book.title!) (\(book.year!))")
                                            .bold()
                                        if !book.isBorrowed {
                                            Text("Borrow available")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
            .onAppear{
                bookVM.fetchAll()
            }
            .navigationTitle("Book Catalog")
            .toolbar {
                NavigationLink(destination: NewBook(), label: {Image(systemName: "plus")})
            }
        }
    }
}

