//
//  CardRarity.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 30/09/22.
//

import SwiftUI

enum CardRarity: String, Codable, Hashable {
    case none, common, uncommon, rare, epic, legendary
    
    var rate: Int {
        switch self {
        case .none:
            return 0
        case .common:
            return 40
        case .uncommon:
            return 30
        case .rare:
            return 20
        case .epic:
            return 10
        case .legendary:
            return 5
        }
    }
}
