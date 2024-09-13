//
//  OnboardingView.swift
//  DayE
//
//  Created by Esther Ramos on 07/02/24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var vm = OnboardingViewModel()
    
    var body: some View {
        VStack {
            tabView
            VStack(spacing: 25) {
                pageIndicator
                largeButton
            }
        }
    }
}

// MARK: - TabView
extension OnboardingView {
    var tabView: some View {
        TabView(selection: $vm.currentTabPage) {
            allPages
        }
        .tabViewStyle(
            .page(indexDisplayMode: .never)
        )
    }
}

// MARK: - TabView Pages
extension OnboardingView {
    var allPages: some View {
        ForEach(1...vm.pages.count, id: \.self) { pageIndex in
            if let page = vm.pages[safe: pageIndex - 1] {
                OnboardingPage(
                    page: page
                )
            }
        }
    }
}

// MARK: - Page Indicator
extension OnboardingView {
    var pageIndicator: some View {
        PageIndicator(
            current: $vm.currentTabPage,
            total: vm.pages.count
        )
    }
}

// MARK: - Large Button
extension OnboardingView {
    var largeButtonHorizontalPadding: CGFloat { 15 }
    var largeButtonBottomPadding: CGFloat { 20 }
    var largeButtonCornerRadius: CGFloat  { 10 }
    var largeButtonTitle: LocalizedStringResource {
        vm.currentTabPage >= vm.pages.count ? "Get Started" : "Next"
    }
    
    var largeButton: some View {
        LargeButton(title: largeButtonTitle) {
            withAnimation {
                vm.isDisplayingLastPage ? dismiss() : vm.displayNextPage()
            }
        }
        .buttonStyle(.plain)
        .clipShape(
            RoundedRectangle(cornerRadius: largeButtonCornerRadius)
        )
        .padding(
            .horizontal,
            largeButtonHorizontalPadding
        )
        .padding(
            .bottom,
            largeButtonBottomPadding
        )
    }
}

#Preview {
    OnboardingView()
}
