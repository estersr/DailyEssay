//
//  Date+Extensions.swift
//  DayE
//
//  Created by Esther Ramos on 15/02/24.
//

import Foundation

extension Date {
    init(_ yyyyMMdd: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self = formatter.date(from: yyyyMMdd) ?? Date()
    }
}

extension Date {
    func isSameDay(_ date2: Date?) -> Bool {
        let date1 = self
        guard let date2 = date2 else { return false }
        let day1 = Calendar.current.component(.day, from: date1)
        let day2 = Calendar.current.component(.day, from: date2)
        let year1 = Calendar.current.component(.year, from: date1)
        let year2 = Calendar.current.component(.year, from: date2)
        let month1 = Calendar.current.component(.month, from: date1)
        let month2 = Calendar.current.component(.month, from: date2)
        return (day1 == day2) && (month1 == month2) && (year1 == year2)
    }
}
