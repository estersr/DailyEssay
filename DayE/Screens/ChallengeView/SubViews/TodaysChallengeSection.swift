//
//  TodaysChallengeSection.swift
//  DayE
//
//  Created by Esther Ramos on 19/02/24.
//

import SwiftUI
import SwiftData

struct TodaysChallengeSection: View, AccessesChallengeOfTheDay {
    @Bindable var vm: ChallengeViewModel
    @Query var challengeDays: [ChallengeDay]
    
    var body: some View {
        Section {
            topicRow
            keywordsRow
        } header: {
            Text("CHALLENGE OF THE DAY")
        } footer: {
            todaysChallengeFooterButton
        }
        .sheet(
            isPresented: $vm.displayingDefinitions
        ) {
            DefinitionsView(
                keywords: challengeOfTheDay?.challenge.keywords ?? []
            )
        }
    }
}

#Preview {
    TodaysChallengeSection(vm: ChallengeViewModel())
}

// MARK: - Today's Challenge Section: Footer Button
extension TodaysChallengeSection {
    var todaysChallengeFooterButton: some View {
        HStack {
            Spacer()
            Button(action: vm.onTapCheckDefinitions) {
                Text("CHECK DEFINITIONS")
                    .font(.footnote.bold())
            }
        }
    }
}

// MARK:  Today's Challenge Section: Topic Row
extension TodaysChallengeSection {
    var topicRow: some View {
        TitledRow(title: "Write a short essay about the topic:") {
            Text(challengeOfTheDay?.challenge.topic ?? "")
                .bold()
        }
    }
}

// MARK:  Today's Challenge Section: Keywords Row
extension TodaysChallengeSection {
    var keywordsRow: some View {
        TitledRow(title: "Use the keywords", padding: true) {
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                keywordsStack
            }
            
        }
        .listRowInsets(
            .zero
        )
    }
}

// MARK: - Today's Challenge Section: Keywords Stack
extension TodaysChallengeSection {
    var spacingBetweenKeywords: CGFloat { 5 }
    var keywordsScrollViewPadding: CGFloat { 20 }
    
    var keywordsStack: some View {
        HStack(spacing: spacingBetweenKeywords) {
            ForEach(challengeOfTheDay?.challenge.words.sorted(by: {String(localized: $0) < String(localized: $1)}) ?? [], id: \.self.key) { keyword in
                KeywordCapsule(
                    title: keyword,
                    isSelected: keyword.localizedContains(in: vm.essay)
                )
            }
        }
        .padding(
            .horizontal,
            keywordsScrollViewPadding
        )
    }
}
