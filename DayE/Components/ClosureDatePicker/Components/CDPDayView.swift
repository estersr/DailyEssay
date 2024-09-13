//
//  DayOfMonthView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI

/**
 * CDPDayView displays the day of month on a CDPContentView. This a button whose color and
 * selectability is determined from the CDPDayOfMonth in the CDPModel.
 */
struct CDPDayView: View {
    @EnvironmentObject var monthDataModel: CDPModel
    let cellSize: CGFloat = 30
    var dayOfMonth: CDPDayOfMonth
    
    // outline "today"
    private var strokeColor: Color {
        dayOfMonth.isToday ? Color.accentColor : Color.clear
    }
    
    //
    var emptyStatusBackground: some View {
        Image(systemName: "circle")
            .resizable()
            .foregroundStyle(strokeColor)
            .background(Circle().foregroundColor(fillColor))
            .frame(width: cellSize, height: cellSize)
    }
    
    // outline finishedEssayDays
    private var essayStatusBackground: some View {
        Group {
            if let usedAllKeywords = dayOfMonth.usedAllKeywords {
                if usedAllKeywords {
                    Image(systemName: "seal.fill")
                        .resizable()
                        .foregroundStyle(essayStatusColor)
                        .frame(width: cellSize, height: cellSize)
                } else {
                    Image(systemName: "seal")
                        .resizable()
                        .foregroundStyle(essayStatusColor)
                        .background(
                            Image(systemName: "seal.fill")
                                .resizable()
                                .foregroundStyle(fillColor)
                        )
                        .frame(width: cellSize, height: cellSize)
                }
            } else {
                emptyStatusBackground
            }
        }
    }
    
    // filled if selected
    private var fillColor: Color {
        monthDataModel.isSelected(dayOfMonth) ? Color.accentColor.opacity(0.2) : Color.clear
    }
    
    private var essayStatusColor: Color {
        monthDataModel.isSelected(dayOfMonth) ? Color.accentColor : Color.primary
    }
    
    // reverse color for selections or gray if not selectable
    private var textColor: Color {
        if dayOfMonth.isSelectable {
            let usedAllKeywords = dayOfMonth.usedAllKeywords == true
            let selectedColor = usedAllKeywords ? Color.white : Color.accentColor
            let unselectedColor = usedAllKeywords ? Color(uiColor: .systemBackground) : Color.primary
                
            return monthDataModel.isSelected(dayOfMonth) ? selectedColor : unselectedColor
        } else {
            return Color.secondary.opacity(0.25)
        }
    }
    
    private func handleSelection() {
        if dayOfMonth.isSelectable {
            if let date = dayOfMonth.date, let onDateSelection = monthDataModel.onDateSelection {
                onDateSelection(date)
                monthDataModel.objectWillChange.send()
            }
        }
    }
    
    var body: some View {
        Button( action: {handleSelection()} ) {
            Text("\(dayOfMonth.day)")
                .font(.caption.bold())
                .fontWeight(.medium)
                .foregroundColor(textColor)
                .frame(minHeight: cellSize, maxHeight: cellSize)
                .background(
                    essayStatusBackground
                )
        }
        .foregroundColor(.primary)
        .buttonStyle(.plain)
    }
}

struct DayOfMonthView_Previews: PreviewProvider {
    static var previews: some View {
        CDPDayView(dayOfMonth: CDPDayOfMonth(index: 0, day: 1, date: Date(), isSelectable: true, isToday: false))
            .environmentObject(
                CDPModel(
                    singleDay: .now,
                    includeDays: .allDays,
                    minDate: nil,
                    maxDate: .now)
            )
    }
}
