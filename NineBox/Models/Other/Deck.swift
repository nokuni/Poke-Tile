//
//  Deck.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import Foundation

struct Deck {
    var name: String = "New Deck"
    var cards: [Card] = Array(repeating: Card.slot, count: 8)
}

extension Deck {
    static let placeholders = Array(repeating: Deck(), count: 10)
}
