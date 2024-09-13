//
//  ToolbarCalendarButton.swift
//  DayE
//
//  Created by Esther Ramos on 21/02/24.
//

import SwiftUI

struct ToolbarCalendarButton: View {
    @Binding var displayingCalendar: Bool
    
    var body: some View {
        Button(
            "Display Calendar",
            systemImage: "calendar"
        ) {
            displayingCalendar.toggle()
        }
    }
}

#Preview {
    ToolbarCalendarButton(displayingCalendar: .constant(false))
}
