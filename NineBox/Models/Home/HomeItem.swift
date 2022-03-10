//
//  HomeItem.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import Foundation

struct HomeItem: Identifiable {
    var id = UUID()
    let icon: String
    let title: String
}

extension HomeItem {
    //static let summons = HomeItem(icon: "pokeball2", title: "Summons")
    static let decks = HomeItem(icon: "decks", title: "Decks")
    static let cards = HomeItem(icon: "cards", title: "Cards")
    static let adventures = HomeItem(icon: "map", title: "Adventure")
    static let achievements = HomeItem(icon: "cards", title: "Achievements")
    static let settings = HomeItem(icon: "settings", title: "Settings")
}
