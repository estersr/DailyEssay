//
//  ChallengeViewModel.swift
//  DayE
//
//  Created by Esther Ramos on 06/02/24.
//

import Foundation

@Observable class ChallengeViewModel {
    // MARK: - Properties
    // Current challenge state
    var essay = ""
    var date = Date()
    var finishedWithAllKeywords: Bool? = nil
    
    // Challenge properties
    var usedEssayChar: Int { essay.count }
    
    // Screen/Flow state
    var displayingOnboarding = false
    var displayingUnsavedChangesAlert = false
    var displayingCalendar = false
    var displayingDefinitions = false
    var displayingConfirmEssayAlert = false
    var dateSelectedOnCalendar = Date()
    
    // MARK: - Methods
    func onTapOnboardingButton() {
        displayingOnboarding.toggle()
    }
    
    func onDiscardUnsavedChangesAndProceed() {
        date = dateSelectedOnCalendar
    }
    
    func onTapCheckDefinitions() {
        displayingDefinitions.toggle()
    }
    
    func onTapConfirmEssayButton() {
        displayingConfirmEssayAlert.toggle()
    }
    
    func launchOnboardingScreens() {
        let defaults = UserDefaults.standard
        let didLaunchOnboardingBefore = "didLaunchOnboardingBefore"
        if !defaults.bool(forKey: didLaunchOnboardingBefore) {
            displayingOnboarding.toggle()
            defaults.set(true, forKey: didLaunchOnboardingBefore)
        }
    }
}
