//
//  ClosureDatePicker.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

/**
 * This component shows a date picker very similar to Apple's SwiftUI DatePicker, but with a difference.
 * Instead of just allowing a date to be picked, the ClosureDatePicker will let you trigger a closure each time the user has picked a date.
 *
 * init(singleDay: Date [,options])
 *      A single-date picker. Selecting a date de-selects the previous selection. There is always a selected date.
 *
 * optional parameters to init() functions are:
 *  - includeDays: .allDays, .weekdaysOnly, .weekendsOnly
 *      Days not selectable are shown in gray and not selected.
 *  - minDate: Date? = nil
 *      Days before minDate are not selectable.
 *  - maxDate: Date? = nil
 *      Days after maxDate are not selectable.
 */
struct ClosureDatePicker: View {
    // Lets all or some dates be elligible for selection.
    enum DateSelectionChoices {
        case allDays
        case weekendsOnly
        case weekdaysOnly
    }
    
    @StateObject var monthModel: CDPModel
    @State private var displayingPopover = false
    var singleDay: Date
    
    init(singleDay: Date,
         includeDays: DateSelectionChoices = .allDays,
         minDate: Date? = nil,
         maxDate: Date? = nil,
         results: [DateEssayResult] = [],
         onDateSelection: ((Date) -> Void)?
    ) {
        _monthModel = StateObject(wrappedValue: CDPModel(singleDay: singleDay, includeDays: includeDays, minDate: minDate, maxDate: maxDate, results: results, onDateSelection: onDateSelection))
        self.singleDay = singleDay
    }
    
    var body: some View {
        CDPMonthView()
            .presentationCompactAdaptation(.none)
            .environmentObject(monthModel)
            .padding()
            .transition(.opacity.combined(with: .scale(0.8, anchor: .topTrailing)))
            .onChange(of: singleDay) { oldValue, newValue in
                monthModel.selections = [newValue]
            }
    }
}

struct MultiDatePicker_Previews: PreviewProvider {
    @State static var oneDay = Date()
    @State static var manyDates = [Date]()
    @State static var dateRange: ClosedRange<Date>? = nil
    
    static var previews: some View {
        ScrollView {
            VStack {
                ClosureDatePicker(singleDay: oneDay, includeDays: .weekdaysOnly, onDateSelection: nil)
            }
        }
    }
}
