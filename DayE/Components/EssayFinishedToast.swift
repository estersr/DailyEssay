//
//  EssayFinishedToast.swift
//  DayE
//
//  Created by Esther Ramos on 21/02/24.
//

import SwiftUI

struct EssayFinishedToast: View {
    @Binding var finishedWithAllKeywords: Bool?
    @State private var timer: Timer? // Used for counting down how long should the Toast be displayed
    
    var body: some View {
        ZStack {
            if let finishedWithAllKeywords {
                tapToDismissBackground
                toastCard(finishedWithAllKeywords: finishedWithAllKeywords)
                
            }
        }
        .animation(.default, value: finishedWithAllKeywords)
        .onChange(of: finishedWithAllKeywords) { _, newValue in
            if newValue != nil {
                timer?.invalidate()
                countdownBeforeDisappearing()
            }
        }
    }
    
    private func countdownBeforeDisappearing() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 4,
            repeats: true,
            block: { (timer) in
                self.finishedWithAllKeywords = nil
                self.timer?.invalidate()
            }
        )
    }
}


// MARK: - Background
extension EssayFinishedToast {
    var tapToDismissBackground: some View {
        Color.black.opacity(0.15)
            .ignoresSafeArea(edges: .all)
            .onTapGesture {
                self.finishedWithAllKeywords = nil
            }
    }
}

// MARK: - Card
extension EssayFinishedToast {
    func toastCard(finishedWithAllKeywords: Bool) -> some View {
        VStack {
            toastCardImage(finishedWithAllKeywords: finishedWithAllKeywords)
            headerAndDescription(finishedWithAllKeywords: finishedWithAllKeywords)
        }
        .padding()
        .frame(
            width: 300,
            height: 350
        )
        .background(
            .regularMaterial
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
        .shadow(radius: 50)
        .transition(
            .opacity.combined(with: .scale(0.8))
        )
    }
}
    
// MARK: - Card's Image
extension EssayFinishedToast {
    func toastCardImage(finishedWithAllKeywords: Bool) -> some View {
        Image(finishedWithAllKeywords ? "trophy_businesswoman" : "pose_happy_businesswoman_banzai")
            .resizable()
            .scaledToFit()
            .blurredCircleBackground()
            .frame(maxHeight: 200)
    }
}
    
// MARK: - Card's Text Stack
extension EssayFinishedToast {
    func headerAndDescription(finishedWithAllKeywords: Bool) -> some View {
        VStack(spacing: 10) {
            Text("Congratulations")
                .font(.title2.bold())
                .foregroundStyle(.accent)
            Text("You've completed the challenge\(finishedWithAllKeywords ? " with all keywords" : "")!")
                .foregroundStyle(.secondary)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
        }
    }
}

#Preview {
    EssayFinishedToast(finishedWithAllKeywords: .constant(true))
}

#Preview {
    EssayFinishedToast(finishedWithAllKeywords: .constant(false))
}
