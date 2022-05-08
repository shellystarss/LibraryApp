//
//  Book+CoreDataProperties.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 08/05/22.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var category: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var isBorrowed: Bool
    @NSManaged public var title: String?
    @NSManaged public var year: String?
    @NSManaged public var recordID: UUID?
    @NSManaged public var record: Record?

}

extension Book : Identifiable {

}
