//
//  KeywordCapsule.swift
//  DayE
//
//  Created by Esther Ramos on 06/02/24.
//

import SwiftUI

struct KeywordCapsule: View {
    var title: LocalizedStringResource
    var isSelected: Bool
    
    var body: some View {
        Text(title)
            .lineLimit(1)
            .foregroundStyle(Color.white)
            .font(.caption2.bold())
            .padding(.vertical, 2.5)
            .padding(.horizontal, 5)
            .background(
                isSelected ? Color.orange : Color.secondary.opacity(0.35)
            )
            .clipShape(Capsule())
            .animation(.default, value: isSelected)
    }
}

#Preview {
    Group {
        KeywordCapsule(
            title: "Virtual Health",
            isSelected: false
        )
        
        KeywordCapsule(
            title: "Virtual Health",
            isSelected: true
        )
    }
}
