//
//  Keyword.swift
//  DayE
//
//  Created by Esther Ramos on 09/02/24.
//

import Foundation
import SwiftData

@Model
class Keyword {
    var word: String
    var definition: String
    
    init(word: String, definition: String) {
        self.word = word
        self.definition = definition
    }
}

extension Keyword {
    static var sample: Keyword {
        Keyword(
            word: "Healthcare Technology",
            definition: "Healthcare technology encompasses the use of innovative tools and systems to improve the delivery, efficiency, and effectiveness of healthcare services. This includes electronic health records (EHR), medical devices, telemedicine platforms, and health apps, all aimed at enhancing patient care, streamlining workflows, and advancing medical research and diagnosis."
        )
    }
}
