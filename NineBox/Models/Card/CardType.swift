//
//  CardType.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

enum CardType: String, Codable, Equatable, Hashable {
    case empty, bug, dark, dragon, electric, fairy, fighting, fire, flying, ghost, grass, ground, ice, normal, poison, psychic, rock, steel, water
    
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
        case .electric:
            return .electricBorder
        case .fairy:
            return .fairyBorder
        case .fighting:
            return .fightingBorder
        case .fire:
            return .fireBorder
        case .flying:
            return .flyingBorder
        case .ghost:
            return .ghostBorder
        case .grass:
            return .grassBorder
        case .ground:
            return .groundBorder
        case .ice:
            return .iceBorder
        case .normal:
            return .normalBorder
        case .poison:
            return .poisonBorder
        case .psychic:
            return .psychicBorder
        case .rock:
            return .rockBorder
        case .steel:
            return .steelBorder
        case .water:
            return .waterBorder
        }
    }
}
