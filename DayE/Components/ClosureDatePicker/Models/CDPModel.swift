//
//  MonthDataModel.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI
import Combine

/**
 * This model is used internally by the ClosureDatePicker to coordinate what is displayed and what
 * is selected.
 *
 * When the controlDate is set, an array of CDPDayOfMonth objects are created, each representing
 * a day of the controlDate's month/year.
 *
 * The CDPModel should not be used outside of the ClosureDatePicker, which initalizes this model
 * according to the type of selection required.
 */
class CDPModel: NSObject, ObservableObject {
    
    // the controlDate determines which month/year is being modeled. whenever it changes it
    // triggers a refresh of the days collection.
    public var controlDate: Date = Date() {
        didSet {
            buildDays()
        }
    }
    
    // this collection is created whenever the controlDate is changed and reflects the
    // days of the month for the controlDate's month/year
    @Published var days = [CDPDayOfMonth]()
    
    // once a controlDate is establed, this value will be the formatted Month Year (localized)
    @Published var title = ""
    
    // this array maintains the selections. for a single date it is an array of 1. for many
    // dates it is an array of those dates. for a date range, it is an array of 2.
    @Published var selections = [Date]()
    
    // the localized days of the week
    let dayNames = Calendar.current.shortWeekdaySymbols
    
    var results: [DateEssayResult] = []
    var onDateSelection: ((Date) -> Void)?
    
    // MARK: - PRIVATE VARS
    
    // holds the bindings from the app and get updated as the selection changes
    private var singleDayWrapper: Date = .now
    
    private var minDate: Date? = nil
    private var maxDate: Date? = nil
    
    // which days are available for selection
    private var selectionType: ClosureDatePicker.DateSelectionChoices = .allDays
    
    // the actual number of days in this calendar month/year (eg, 28 for February)
    private var numDays = 0
    
    // MARK: - INIT
    
    convenience init(singleDay: Date,
                     includeDays: ClosureDatePicker.DateSelectionChoices,
                     minDate: Date?,
                     maxDate: Date?,
                     results: [DateEssayResult] = [],
                     onDateSelection: ((Date) -> Void)? = nil) {
        self.init()
        self.singleDayWrapper = singleDay
        self.selectionType = includeDays
        self.minDate = minDate
        self.maxDate = maxDate
        self.results = results
        self.onDateSelection = onDateSelection
        setSelection(singleDay)
        
        // set the controlDate to be this singleDay
        controlDate = singleDay
        buildDays()
    }
    
    // MARK: - PUBLIC
    
    func dayOfMonth(byDay: Int) -> CDPDayOfMonth? {
        guard 1 <= byDay && byDay <= 31 else { return nil }
        for dom in days {
            if dom.day == byDay {
                return dom
            }
        }
        return nil
    }
    
    func isSelected(_ day: CDPDayOfMonth) -> Bool {
        guard day.isSelectable else { return false }
        guard let date = day.date else { return false }
        
        for test in selections {
            if test.isSameDay(date) {
                return true
            }
        }
        return false
    }
    
    func incrMonth() {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: 1, to: controlDate) {
            controlDate = newDate
        }
    }
    
    func decrMonth() {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: -1, to: controlDate) {
            controlDate = newDate
        }
    }
    
    func show(month: Int, year: Int) {
        let calendar = Calendar.current
        let components = DateComponents(year: year, month: month, day: 1)
        if let newDate = calendar.date(from: components) {
            controlDate = newDate
        }
    }
    
}

// MARK: - BUILD DAYS

extension CDPModel {
    
    private func buildDays() {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: controlDate)
        let month = calendar.component(.month, from: controlDate)
        
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        let ord = calendar.component(.weekday, from: date)
        var index = 0
        
        let today = Date()
        
        // create an empty int array
        var daysArray = [CDPDayOfMonth]()
        
        // for 0 to ord, set the value in the array[index] to be 0, meaning no day here.
        for _ in 1..<ord {
            daysArray.append(CDPDayOfMonth(index: index, day: 0))
            index += 1
        }
        
        // for index in range, create a DayOfMonth that will represent one of the days
        // in the month. This object needs to be told if it is eligible for selection
        // which is based on the selectionType and min/max dates if present.
        for i in 0..<numDays {
            let realDate = calendar.date(from: DateComponents(year: year, month: month, day: i+1))
            var dom = CDPDayOfMonth(index: index, day: i+1, date: realDate)
            dom.isToday = today.isSameDay(realDate)
            dom.usedAllKeywords = results.first(
                where: {
                    $0.date.isSameDay(realDate)
                }
            )?.usedAllKeywords
            dom.isSelectable = isEligible(date: realDate)
            daysArray.append(dom)
            index += 1
        }
        
        // if index is not a multiple of 7, then append 0 to array until the next 7 multiple.
        let total = daysArray.count
        var remainder = 42 - total
        if remainder < 0 {
            remainder = 42 - total
        }
        
        for _ in 0..<remainder {
            daysArray.append(CDPDayOfMonth(index: index, day: 0))
            index += 1
        }
        
        self.numDays = numDays
        self.title = "\(calendar.monthSymbols[month-1]) \(year)"
        self.days = daysArray
    }
}

// MARK: - UTILITIES

extension CDPModel {
    
    private func setSelection(_ date: Date) {
        selections = [date]
    }
    
    private func isEligible(date: Date?) -> Bool {
        guard let date = date else { return true }
                
        if let minDate = minDate, let maxDate = maxDate {
            return (minDate...maxDate).contains(date)
        } else if let minDate = minDate {
            return date >= minDate
        } else if let maxDate = maxDate {
            return date <= maxDate
        }
        
        switch selectionType {
        case .weekendsOnly:
            let ord = Calendar.current.component(.weekday, from: date)
            return ord == 1 || ord == 7
        case .weekdaysOnly:
            let ord = Calendar.current.component(.weekday, from: date)
            return 1 < ord && ord < 7
        default:
            return true
        }
    }
}
