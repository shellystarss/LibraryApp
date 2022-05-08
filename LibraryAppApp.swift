//
//  LibraryAppApp.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import SwiftUI

@main
struct LibraryAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
