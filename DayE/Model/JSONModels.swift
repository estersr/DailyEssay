//
//  JSONModels.swift
//  DayE
//
//  Created by Esther Ramos on 22/02/24.
//

import Foundation

// MARK: - JSONChallengeCollection
struct JSONChallengeCollection: Codable {
    let challenges: [JSONChallenge]
}
extension JSONChallengeCollection {
    static let allChallenges: [JSONChallenge] = {
        do {
            guard let path = Bundle.main.path(forResource: "Challenges", ofType: "json") else {
                fatalError("Couldn't find Challenges.json in the main bundle")
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(JSONChallengeCollection.self, from: data)
            return decoded.challenges
        } catch {
            print(error.localizedDescription)
        }
        return []
    }()
}

// MARK: - JSONChallenge
struct JSONChallenge: Codable {
    let topic: String
    let keywords: [JSONKeyword]
}

// MARK: - JSONKeyword
struct JSONKeyword: Codable {
    let word, definition: String
}
