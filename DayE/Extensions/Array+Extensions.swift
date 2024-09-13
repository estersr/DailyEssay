//
//  Array+Extensions.swift
//  DayE
//
//  Created by Esther Ramos on 07/02/24.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
