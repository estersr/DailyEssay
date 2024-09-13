//
//  MonthContentView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

/**
 * Displays the calendar of CDPDayOfMonth items using CDPDayView views.
 */
struct CDPContentView: View {
    @EnvironmentObject var monthDataModel: CDPModel
    
    let cellSize: CGFloat = 30
    
    var columns: [GridItem] {
        [GridItem](
            repeating: GridItem(
                .fixed(cellSize),
                spacing: 2
            ),
            count: 7
        )
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            
            // Sun, Mon, etc.
            ForEach(0..<monthDataModel.dayNames.count, id: \.self) { index in
                Text(monthDataModel.dayNames[index].uppercased())
                    .font(.caption.bold())
                    .foregroundColor(.secondary.opacity(0.5))
            }
            .padding(.bottom, 10)
            
            // The actual days of the month.
            ForEach(0..<monthDataModel.days.count, id: \.self) { index in
                if monthDataModel.days[index].day == 0 {
                    Text("")
                        .frame(minHeight: cellSize, maxHeight: cellSize)
                } else {
                    CDPDayView(dayOfMonth: monthDataModel.days[index])
                }
            }
        }.padding(.bottom, 10)
    }
}

struct MonthContentView_Previews: PreviewProvider {
    static var previews: some View {
        CDPContentView()
            .environmentObject(
                CDPModel(
                    singleDay: .now,
                    includeDays: .allDays,
                    minDate: nil,
                    maxDate: .now)
            )
    }
}
