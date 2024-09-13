//
//  LargeButton.swift
//  DayE
//
//  Created by Esther Ramos on 06/02/24.
//

import SwiftUI

struct LargeButton: View {
    var title: LocalizedStringResource
    var disabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            buttonLabel
        }
        .disabled(disabled)
        .buttonStyle(.plain)
    }
}

// MARK: - Button Label
extension LargeButton {
    var height: CGFloat { 44 }
    
    var buttonLabel: some View {
        Text(title)
            .textCase(.uppercase)
            .bold()
            .foregroundStyle(.white)
            .frame(height: height)
            .frame(
                maxWidth: .infinity
            )
            .background(.orange)
    }
}

#Preview {
    LargeButton(title: "Confirm essay") {
        
    }
    .frame(maxHeight: 100)
}
