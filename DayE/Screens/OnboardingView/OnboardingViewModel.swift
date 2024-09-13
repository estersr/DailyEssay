//
//  OnboardingViewModel.swift
//  DayE
//
//  Created by Esther Ramos on 07/02/24.
//

import SwiftUI

@Observable class OnboardingViewModel {
    // MARK: - Properties
    var currentTabPage = 1
    let pages: [OnboardingPageModel] = [
        OnboardingPageModel(
            image:  Image("calender_himekuri"),
            title: "Get a new challenge everyday",
            description: "Every day, our app challenges you to write an essay on thought-provoking topics."
        ),
        OnboardingPageModel(
            image:  Image("write_woman"),
            title: "Improve your writing skills",
            description: "Explore new topics to refine your writing skills and witness your proficiency flourish!"
        ),
        OnboardingPageModel(
            image:  Image("business_plus_woman"),
            title: "Optimize your cognitive abilities",
            description: "By making it a daily ritual, you'll enhance memory, agility, reasoning, and expand your vocabulary—all in one go!"
        )
    ]
    var isDisplayingLastPage: Bool {
        currentTabPage >= pages.count
    }
    
    // MARK: - Methods
    func displayNextPage() {
        let nextPage = currentTabPage + 1
        if pages[safe: nextPage - 1] != nil {
            currentTabPage = nextPage
        }
    }
}
