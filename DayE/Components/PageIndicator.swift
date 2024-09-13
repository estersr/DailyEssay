//
//  PageIndicator.swift
//  DayE
//
//  Created by Esther Ramos on 07/02/24.
//

import SwiftUI

struct PageIndicator: View {
    @Binding var current: Int
    let total: Int
    var body: some View {
        HStack(spacing: 10) {
            ForEach(1...total, id: \.self) { page in
                getCircle(for: page)
            }
        }
        .animation(
            .default,
            value: current
        )
    }
}

// MARK: - Circle View
extension PageIndicator {
    var circleSize: CGFloat { 8 }
    
    func getColor(for page: Int) -> Color {
        current == page ? Color.accentColor : .accentColor.opacity(0.2)
    }
    
    func getCircle(for page: Int) -> some View {
        Circle()
            .fill(
                getColor(for: page)
            )
            .frame(
                width: circleSize,
                height: circleSize
            )
    }
}

#Preview {
    PageIndicator(
        current: .constant(1),
        total: 2
    )
}

