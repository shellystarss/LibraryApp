//
//  Home.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 07/05/22.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        TabView {
            Catalog()
                .tabItem {
                    Label("Catalog", systemImage: "book")
                }
            
            Records()
                .tabItem {
                    Label("Records", systemImage: "list.dash")
                }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
