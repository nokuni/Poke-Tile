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
    static let pokemons = NavigationTitleModel(image: "025", title: "Pokemons", color: .mediumSeaGreen)
    static let adventure = NavigationTitleModel(image: "map01", title: "Adventure", color: .steelBlue)
    static let trainer = NavigationTitleModel(image: "trainer", title: "Trainers", color: .dodgerBlue)
    static let decks = NavigationTitleModel(image: "trainer", title: "Decks", color: .purple)
    static let preBattle = NavigationTitleModel(image: "trainer", title: "Battle Preparation", color: .dodgerBlue)
}
