//
//  OnboardingPage.swift
//  DayE
//
//  Created by Esther Ramos on 07/02/24.
//

import SwiftUI

struct OnboardingPage: View {
    var page: OnboardingPageModel
    
    var body: some View {
        VStack(spacing: 25) {
            imageView
            titleView
            descriptionView
        }
        .frame(maxHeight: .infinity)
        .padding()
    }
}

// MARK: - Image View
extension OnboardingPage {
    var imageHeight: CGFloat { 250 }
    var imageView: some View {
        page.image
            .resizable()
            .scaledToFit()
            .frame(height: imageHeight)
    }
}

// MARK: - Title View
extension OnboardingPage {
    var titleView: some View {
        Text(page.title)
            .multilineTextAlignment(.center)
            .font(.title2.bold())
            .foregroundStyle(.accent)
    }
}

// MARK: - Description View
extension OnboardingPage {
    var descriptionView: some View {
        Text(page.description)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    OnboardingPage(
        page: OnboardingPageModel(
            image: Image("calender_himekuri"),
            title: "Get a new challenge everyday",
            description: "Each day, our app meticulously selects a thought-provoking essay topic, tailored to inspire and challenge you."
        )
    )
}
