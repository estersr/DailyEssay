//
//  Challenge.swift
//  DayE
//
//  Created by Esther Ramos on 06/02/24.
//

import Foundation
import SwiftData

@Model
class Challenge {
    var topic: String
    @Relationship(deleteRule: .cascade) var keywords: [Keyword]
    
    init(topic: String, keywords: [Keyword]) {
        self.topic = topic
        self.keywords = keywords
    }
    
    init() {
        guard let randomChallenge = JSONChallengeCollection.allChallenges.randomElement() else {
            self.topic = ""
            self.keywords = []
            return
        }
        
        self.topic = randomChallenge.topic
        self.keywords = randomChallenge.keywords.map {
            Keyword(word: $0.word, definition: $0.definition)
        }
    }
}

extension Challenge {
    var words: [LocalizedStringResource] {
        keywords
            .map {
                LocalizedStringResource(stringLiteral: $0.word)
            }
    }
}
