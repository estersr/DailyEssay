//
//  CloseButton.swift
//  DayE
//
//  Created by Esther Ramos on 09/02/24.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            label
        }
        .buttonStyle(.plain)
    }
}

extension CloseButton {
    var label: some View {
        Image(systemName: "xmark")
            .font(.caption2)
            .fontWeight(.heavy)
            .foregroundStyle(.secondary)
            .padding(8)
            .background(
                Color.secondary.opacity(0.2)
            )
            .clipShape(Circle())
    }
}

#Preview {
    CloseButton()
}
