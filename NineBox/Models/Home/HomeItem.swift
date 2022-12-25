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
    var isUnlocked: Bool = false
}

extension HomeItem {
    static let summons = HomeItem(icon: "summons", title: "Summons")
    static let decks = HomeItem(icon: "decks", title: "Decks")
    static let cards = HomeItem(icon: "cards", title: "Cards")
    static let adventures = HomeItem(icon: "adventure", title: "Adventures")
    static let missions = HomeItem(icon: "missions", title: "Missions")
    static let settings = HomeItem(icon: "settings", title: "Settings")
    
    static let all = [summons, decks, cards, adventures, missions]
}
