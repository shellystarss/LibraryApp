//
//  Persistence.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LibraryApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func getAllBooks() -> [Book] {
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getBookById(id: NSManagedObjectID) -> Book? {
        do {
            return try viewContext.existingObject(with: id) as? Book
        } catch {
            return nil
        }
    }
    
    func getAllRecords() -> [Record] {
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getRecordById(id: NSManagedObjectID) -> Record? {
        do {
            return try viewContext.existingObject(with: id) as? Record
        } catch {
            return nil
        }
    }
    
    func getSelectedRecord(id: UUID) -> Record? {
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.predicate = NSPredicate(format: "id LIKE %@", id as CVarArg)
        do{
            return try viewContext.fetch(request).first
        }catch{
            return nil
        }
    }
    
    func deleteRecord(record: Record) {
        viewContext.delete(record)
        save()
    }
    
    // MARK: Coredata saving function
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}
