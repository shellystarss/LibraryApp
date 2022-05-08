//
//  NewBook.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import SwiftUI

struct NewBook: View {
    @StateObject var bookVM = BookViewModel()
    @Environment(\.presentationMode) var presentationMode
    let categories = ["Science", "Art", "History", "Philosophy", "Business", "Fiction"]
    
    //form
    @State private var title = ""
    @State private var author = ""
    @State private var year = ""
    @State private var category = ""
    @State private var image: Data = .init(count: 0)
    
    //alert
    @State private var showingAlert = false
    @State private var show = false
    
    @State private var isImage = false
    
    func resetForm(){
        title = ""
        author = ""
        year = ""
        category = ""
        image = .init(count: 0)
    }
    
    var body: some View {
        VStack {
            VStack {
                if self.image.count != 0 {
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Image(uiImage: UIImage(data: self.image)!)
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                } else {
                    Button(action: {
                        self.show.toggle()
                    }) {
                        Image(systemName: "photo.fill")
                            .frame(width: 200, height: 200)
                    }
                }
            }
            
            
            Form {
                Section {
                    TextField("Book's title", text: $title)
                    TextField("Author's name", text: $author)
                    TextField("Release year", text: $year)
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Button("Save") {
                        if (!title.isEmpty || !author.isEmpty || !year.isEmpty || !category.isEmpty || !image.isEmpty) {
                            bookVM.addBook(title: title, author: author, year: year, category: category, image: image)
                            showingAlert = true
                            resetForm()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }.alert("Book added", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }.sheet(isPresented: $show, content: {
                        ImagePicker(show: self.$show, image: self.$image)
                    })
                }
            }
            .navigationTitle("New Book")
        }
    }
}

