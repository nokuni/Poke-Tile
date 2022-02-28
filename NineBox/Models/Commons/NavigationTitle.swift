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
    static let adventure = NavigationTitleModel(image: "map", title: "Adventure", color: .mediumSeaGreen)
    static let trainer = NavigationTitleModel(image: "trainer", title: "Trainers", color: .mediumSeaGreen)
    static let decks = NavigationTitleModel(image: "decks", title: "Decks", color: .orangeDragonite)
    static let preBattle = NavigationTitleModel(image: "battle", title: "Battle Preparation", color: .crimson)
}
