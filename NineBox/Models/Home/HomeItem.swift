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
    static let summons = HomeItem(icon: "pokeball2", title: "Summons")
    static let adventures = HomeItem(icon: "map", title: "Adventure")
    static let decks = HomeItem(icon: "decks", title: "Decks")
    static let shop = HomeItem(icon: "shop", title: "Shop")
    static let settings = HomeItem(icon: "settings", title: "Settings")
}
