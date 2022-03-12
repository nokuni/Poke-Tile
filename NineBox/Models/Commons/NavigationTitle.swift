//
//  NavigationTitle.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct NavigationTitleModel {
    var image: String
    var title: String
    var color: Color
}

extension NavigationTitleModel {
    static let decks = NavigationTitleModel(image: "decks", title: "Decks", color: .orangeDragonite)
    static let cards = NavigationTitleModel(image: "cards", title: "Cards", color: .fairyBorder)
    static let adventure = NavigationTitleModel(image: "adventure", title: "Adventure", color: .mediumSeaGreen)
    static let missions = NavigationTitleModel(image: "missions", title: "Missions", color: .flyingBorder)
    static let trainer = NavigationTitleModel(image: "trainer", title: "Trainers", color: .mediumSeaGreen)
    static let preBattle = NavigationTitleModel(image: "battle", title: "Battle Preparation", color: .crimson)
    static let deckCreation = NavigationTitleModel(image: "decks", title: "Deck Creation", color: .limeGreen)
}
