//
//  DefinitionSection.swift
//  DayE
//
//  Created by Esther Ramos on 09/02/24.
//

import SwiftUI

struct DefinitionSection: View {
    var title: LocalizedStringResource
    var description: LocalizedStringResource
    let spacing: CGFloat = 10
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: spacing
        ) {
            Text(title)
                .font(.headline.bold())
                .foregroundStyle(.accent)
            Text(description)
                .foregroundStyle(.secondary)
        }
        .padding(
            .vertical, spacing
        )
    }
}

#Preview {
    List {
        DefinitionSection(
            title: "Healthcare Technology",
            description: "Healthcare technology encompasses the use of innovative tools and systems to improve the delivery, efficiency, and effectiveness of healthcare services. This includes electronic health records (EHR), medical devices, telemedicine platforms, and health apps, all aimed at enhancing patient care, streamlining workflows, and advancing medical research and diagnosis."
        )
    }
    .listStyle(.inset)
}
