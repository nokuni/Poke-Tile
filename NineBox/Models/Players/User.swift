//
//  User.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import Foundation

struct User {
    var profile: Profile
    var cards: [Card] = Card.pokemons
    var decks: [Deck] = Deck.all
}

extension User {
    static let previewExample = User(profile: Profile(name: "User", image: "blaine"))
}
