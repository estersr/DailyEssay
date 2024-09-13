//
//  ConfirmEssayButton.swift
//  DayE
//
//  Created by Esther Ramos on 21/02/24.
//

import SwiftUI
import SwiftData

struct ConfirmEssayButton: View, AccessesChallengeOfTheDay {
    @Bindable var vm: ChallengeViewModel
    @Query var challengeDays: [ChallengeDay]
    
    var essayConfirmed: Bool {
        guard let storedEssay = challengeOfTheDay?.essay else { return false}
        return !storedEssay.isEmpty
    }
    
    var body: some View {
        if challengeOfTheDay?.essay.isEmpty ?? false {
            LargeButton(
                title: "Confirm essay",
                disabled: vm.essay.isEmpty || essayConfirmed,
                action: vm.onTapConfirmEssayButton
            )
            .listRowInsets(
                .zero
            )
            .alert(
                "Confirm Essay?",
                isPresented: $vm.displayingConfirmEssayAlert,
                actions: {
                    Button("Confirm", action: onConfirmEssay)
                    Button("Cancel", role: .cancel) {}
                },
                message: {
                    Text("This action cannot be undone.")
                }
            )
        } else {
            Text("You've completed the challenge of the day!\nCheck the calendar to catch up on any missed days, or come back tomorrow for a brand new challenge.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .listRowBackground(Color.clear)

        }
    }
    
    func onConfirmEssay() {
        challengeOfTheDay?.essay = vm.essay
        vm.finishedWithAllKeywords = challengeOfTheDay?.didFinishWithAllWords
    }
}

#Preview {
    ConfirmEssayButton(vm: ChallengeViewModel())
}
