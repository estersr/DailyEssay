//
//  String+Extensions.swift
//  DayE
//
//  Created by Esther Ramos on 19/02/24.
//

import Foundation

extension String {
    var localized: LocalizedStringResource {
        LocalizedStringResource(stringLiteral: self)
    }
}
