//
//  Date.swift
//  LibraryApp
//
//  Created by Shelina Linardi on 08/05/22.
//

import Foundation
extension Date {
    public func getReturnDate(borrowDate: Date) -> Date {
        let currentDate = borrowDate
        var dateComponent = DateComponents()
        dateComponent.day = 7
        let futureDate: Date = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
        return futureDate
    }
}

