//
//  LocalizedStringResource+Extensions.swift
//  DayE
//
//  Created by Esther Ramos on 22/02/24.
//

import Foundation

extension LocalizedStringResource {
    func localizedContains(in text: String) -> Bool {
        let stringLocalizedKeyword = String(localized: self)
        let essayContainsKeyword = text.localizedStandardContains(stringLocalizedKeyword)
        return essayContainsKeyword
    }
}
