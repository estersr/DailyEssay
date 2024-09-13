//
//  TitledRow.swift
//  DayE
//
//  Created by Esther Ramos on 06/02/24.
//

import SwiftUI

struct TitledRow<Content: View>: View {
    var title: LocalizedStringResource
    var padding: Bool = false
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal, padding ? 20 : 0)
            content
        }
        .padding(.vertical, padding ? 10 : 0)
    }
}

#Preview {
    TitledRow(title: "Write a short essay about the topic:") {
        Text("The Future of Healthcare: Telemedicine and Remote Patient Monitoring")
            .bold()
    }
}
