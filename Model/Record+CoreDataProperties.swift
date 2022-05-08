//
//  Record+CoreDataProperties.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 08/05/22.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var bookID: UUID?
    @NSManaged public var borrowDate: Date?
    @NSManaged public var borrowerName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var returnDate: Date?
    @NSManaged public var book: Book?

}

extension Record : Identifiable {

}
