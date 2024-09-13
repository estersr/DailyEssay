//
//  MonthView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI

/**
 * CDPMonthView is really the crux of the control. This displays everything and handles the interactions
 * and selections. ClosureDatePicker is the public interface that sets up the model and this view.
 */
struct CDPMonthView: View {
    @EnvironmentObject var monthDataModel: CDPModel
        
    @State private var showMonthYearPicker = false
    @State private var testDate = Date()
    
    private func showPrevMonth() {
        withAnimation {
            monthDataModel.decrMonth()
            showMonthYearPicker = false
        }
    }
    
    private func showNextMonth() {
        withAnimation {
            monthDataModel.incrMonth()
            showMonthYearPicker = false
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: .zero) {
                CDPMonthYearPickerButton(isPresented: self.$showMonthYearPicker)
                Spacer()
                Button( action: {showPrevMonth()} ) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .fontWeight(.semibold)
                }.padding()
                Button( action: {showNextMonth()} ) {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                }.padding()
            }
            .padding(.leading, 18)
            
            GeometryReader { reader in
                if showMonthYearPicker {
                    CDPMonthYearPicker(date: monthDataModel.controlDate) { (month, year) in
                        self.monthDataModel.show(month: month, year: year)
                    }
                }
                else {
                    CDPContentView()
                }
            }
        }
        .background(
            .regularMaterial
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .frame(width: 300, height: 300)
        .shadow(radius: 50)
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        CDPMonthView()
            .environmentObject(
                CDPModel(
                    singleDay: .now,
                    includeDays: .allDays,
                    minDate: nil,
                    maxDate: .now)
            )
    }
}
