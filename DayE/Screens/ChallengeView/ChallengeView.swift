//
//  ChallengeView.swift
//  DayE
//
//  Created by Esther Ramos on 05/02/24.
//

import SwiftUI
import SwiftData

struct ChallengeView: View, AccessesChallengeOfTheDay {
    @State var vm = ChallengeViewModel()
    @Query var challengeDays: [ChallengeDay]
    
    var body: some View {
        NavigationStack {
            Form {
                TodaysChallengeSection(vm: vm)
                EssayTextSection(vm: vm)
                ConfirmEssayButton(vm: vm)
            }
            .animation(.default, value: challengeOfTheDay)
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(
                Text(vm.date , style: .date)
            )
            .toolbar {
                toolbarItems
            }
            .sheet(
                isPresented: $vm.displayingOnboarding
            ) {
                OnboardingView()
            }
            .alert("You have unsaved changes left", isPresented: $vm.displayingUnsavedChangesAlert) {
                Button("Discard", role: .destructive, action: vm.onDiscardUnsavedChangesAndProceed)
                Button("Cancel", role: .cancel) {}
            }
            .onAppear {
                vm.launchOnboardingScreens()
            }
        }
        .overlay(
            CalendarView(vm: vm)
        )
        .overlay(
            EssayFinishedToast(finishedWithAllKeywords: $vm.finishedWithAllKeywords)
        )
    }
}

// MARK: - Toolbar Items
extension ChallengeView {
    var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolbarOnboardingButton
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                ToolbarCalendarButton(displayingCalendar: $vm.displayingCalendar)
            }
        }
    }
}

// MARK: - Toolbar Items: Onboarding
extension ChallengeView {
    var toolbarOnboardingButton: some View {
        Button(
            "Display Introduction",
            systemImage: "questionmark.circle",
            action: vm.onTapOnboardingButton
        )
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ChallengeDay.self, configurations: config)
        return ChallengeView()
            .modelContainer(container)
    } catch {
        fatalError()
    }
}
