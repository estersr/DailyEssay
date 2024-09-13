//
//  View+Extensions.swift
//  DayE
//
//  Created by Esther Ramos on 23/02/24.
//

import SwiftUI

extension View {
    func blurredCircleBackground() -> some View {
        self
            .modifier(BlurredCircleBackground())
    }
}

struct BlurredCircleBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Circle()
                    .foregroundStyle(
                        .accent.opacity(0.3)
                    )
                    .blur(radius: 35)
            )
    }
}
