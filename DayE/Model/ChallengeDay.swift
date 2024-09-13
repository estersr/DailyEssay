//
//  ChallengeDay.swift
//  DayE
//
//  Created by Esther Ramos on 19/02/24.
//

import Foundation
import SwiftData

@Model
class ChallengeDay {
    @Relationship(deleteRule: .cascade) var challenge: Challenge
    var essay: String
    var date: Date
    
    init(challenge: Challenge, essay: String, date: Date) {
        self.challenge = challenge
        self.essay = essay
        self.date = date
    }
}

// Computed property to check what is the status of the challenge.
extension ChallengeDay {
    var didFinishWithAllWords: Bool? {
        guard !essay.isEmpty else { return nil }
        
        var didFinishWithAllWords = true

        for keyword in challenge.keywords {
            let localizedKeyword = LocalizedStringResource(stringLiteral: keyword.word)
            let essayContainsKeyword = localizedKeyword.localizedContains(in: essay)
            
            if !essayContainsKeyword {
                didFinishWithAllWords = false
            }
        }
        
        return didFinishWithAllWords
    }
}

// Mapping any array of ChallengeDay only with data that is relevant to the calendar.
extension [ChallengeDay] {
    var calendarInfo: [DateEssayResult] {
        self.compactMap {
            if let didFinishWithAllWords = $0.didFinishWithAllWords {
                return DateEssayResult(date: $0.date, usedAllKeywords: didFinishWithAllWords)
            } else {
                return nil
            }
        }
    }
}
