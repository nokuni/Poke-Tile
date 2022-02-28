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
    static let summons = HomeItem(icon: "001", title: "Summons")
    static let adventures = HomeItem(icon: "map", title: "Adventure")
    static let pokemons = HomeItem(icon: "pokeball", title: "Pokemons")
    static let shop = HomeItem(icon: "shop", title: "Shop")
    static let settings = HomeItem(icon: "settings", title: "Settings")
}
