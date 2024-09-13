//
//  EssayTextSection.swift
//  DayE
//
//  Created by Esther Ramos on 22/02/24.
//

import SwiftUI
import SwiftData

struct EssayTextSection: View, AccessesChallengeOfTheDay {
    @Bindable var vm: ChallengeViewModel
    @Query var challengeDays: [ChallengeDay]
    
    var isTextDisabled: Bool {
        !(challengeOfTheDay?.essay.isEmpty ?? false)
    }
    
    var body: some View {
        Section {
            essayEditor
        } footer: {
            Text("CHARACTERS USED \(vm.usedEssayChar)")
        }
    }
}

// MARK: - EssayEditorSection: Essay Editor
extension EssayTextSection {
    var essayEditorHeight: CGFloat {
        UIScreen.main.bounds.height/100 * 25
    }
    
    var essayEditor: some View {
        TextField(
            "Write your essay here...",
            text: $vm.essay,
            axis: .vertical
        )
        .frame(
            minHeight: essayEditorHeight,
            alignment: .top
        )
        .foregroundStyle(isTextDisabled ? .secondary : .primary)
        .disabled(isTextDisabled)
    }
}

#Preview {
    EssayTextSection(vm: ChallengeViewModel())
}
