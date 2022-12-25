//
//  NavigationTitle.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

enum NavigationTitleModel: String, CaseIterable {
    case summons, decks, cards, adventure, missions, world, trainers, lab, training, preBattle, deckCreation
    
    var color: Color {
        switch self {
        case .summons:
            return .steelBlue
        case .decks:
            return .darkOrange
        case .cards:
            return .fairyBorder
        case .adventure:
            return .steelBlue
        case .missions:
            return .flyingBorder
        case .world:
            return .grassBorder
        case .trainers:
            return .mediumSeaGreen
        case .lab:
            return .flyingBorder
        case .training:
            return .flyingBorder
        case .preBattle:
            return .crimson
        case .deckCreation:
            return .limeGreen
        }
    }
}
