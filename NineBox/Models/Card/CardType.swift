//
//  CardType.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

enum CardType: String, Codable, Equatable, Hashable, CaseIterable {
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
    
    var legendaryHexBackground: String {
        switch self {
        case .empty:
            return ""
        case .bug:
            return "bug_hex"
        case .dark:
            return "dark_hex"
        case .dragon:
            return "dragon_hex"
        case .electric:
            return "electric_hex"
        case .fairy:
            return "fairy_hex"
        case .fighting:
            return "fighting_hex"
        case .fire:
            return "fire_hex"
        case .flying:
            return "flying_hex"
        case .ghost:
            return "ghost_hex"
        case .grass:
            return "grass_hex"
        case .ground:
            return "ground_hex"
        case .ice:
            return "ice_hex"
        case .normal:
            return "normal_hex"
        case .poison:
            return "poison_hex"
        case .psychic:
            return "psychic_hex"
        case .rock:
            return "rock_hex"
        case .steel:
            return "steel_hex"
        case .water:
            return "water_hex"
        }
    }
}
