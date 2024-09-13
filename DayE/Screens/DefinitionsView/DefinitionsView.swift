//
//  DefinitionsView.swift
//  DayE
//
//  Created by Esther Ramos on 09/02/24.
//

import SwiftUI
import SwiftData

struct DefinitionsView: View {
    var keywords: [Keyword]
    
    var body: some View {
        NavigationStack {
            List {
                illustration
                ForEach(
                    keywords.sorted {
                        String(localized: $0.word.localized) < String(localized: $1.word.localized)
                    }
                ) {
                    DefinitionSection(
                        title: $0.word.localized,
                        description: $0.definition.localized
                    )
                }
            }
            .listStyle(.plain)
            .navigationTitle("Definitions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CloseButton()
                }
            }
        }
    }
}

extension DefinitionsView {
    private var illustrationHeight: CGFloat { 150 }
    var illustration: some View {
        Image("business_woman_question")
            .resizable()
            .scaledToFit()
            .frame(maxHeight: illustrationHeight)
            .blurredCircleBackground()
            .frame(maxWidth: .infinity)
            .padding(.top)
            .listRowInsets(.zero)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Keyword.self, configurations: config)
        return DefinitionsView(
            keywords: [.sample, .sample, .sample]
        )
        .modelContainer(container)
    } catch {
        fatalError()
    }
}
