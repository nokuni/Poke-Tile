//
//  Deck.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import Foundation

struct Deck: Codable {
    var name: String
    var pokemons: [String]
    var background: String
    
    var cards: [Card] {
        return pokemons.map { try! Card.getPokemon(name: $0) }
    }
    
    var types: [String] {
        return cards.map { $0.backgroundImage }.uniqued()
    }
}

extension Deck {
    static let all: [Deck] = try! Bundle.main.decode("decks.json")
}
