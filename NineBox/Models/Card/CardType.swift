//
//  CardType.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

enum CardType: String, Codable, Equatable {
    case empty, bug, dark, dragon, fire, ghost, grass, normal, water, ground
    
    var color: Color {
        switch self {
        case .empty:
            return .black
        case .bug:
            return .bugBorder
        case .dark:
            return .darkBorder
        case .dragon:
            return .dragonBorder
        case .fire:
            return .fireBorder
        case .ghost:
            return .ghostBorder
        case .grass:
            return .grassBorder
        case .normal:
            return .normalBorder
        case .water:
            return .waterBorder
        case .ground:
            return .groundBorder
        }
    }
}
