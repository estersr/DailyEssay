//
//  DayEApp.swift
//  DayE
//
//  Created by Esther Ramos on 05/02/24.
//

import SwiftData
import SwiftUI

@main
struct DayEApp: App {
    var body: some Scene {
        WindowGroup {
            ChallengeView()
        }
        .modelContainer(for: ChallengeDay.self)
    }
}
