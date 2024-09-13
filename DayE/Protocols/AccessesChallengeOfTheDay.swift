//
//  AccessesChallengeOfTheDay.swift
//  DayE
//
//  Created by Esther Ramos on 23/02/24.
//

import Foundation

protocol AccessesChallengeOfTheDay {
    var vm: ChallengeViewModel { get }
    var challengeDays: [ChallengeDay] { get }
}

extension AccessesChallengeOfTheDay {
    var challengeOfTheDay: ChallengeDay? {
        return locateChallenge(for: vm.date)
    }
    
    func locateChallenge(for date: Date) -> ChallengeDay? {
        challengeDays.first {
            $0.date.isSameDay(date)
        }
    }
}
