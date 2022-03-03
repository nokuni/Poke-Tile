//
//  Deck.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import Foundation

struct Deck: Codable, Identifiable {
    var id = UUID()
    var name: String
    var pokemons: [String]
    var background: String
    
    enum CodingKeys: String, CodingKey {
        case name, pokemons, background
    }
    
    var cards: [Card] {
        return pokemons.map { try! Card.getPokemon(name: $0) }
    }
    
    var types: [String] {
        return cards.map { $0.backgroundImage }.uniqued()
    }
    
    var cost: Int {
        let costs = cards.map { $0.cost }
        return costs.reduce(0, +)
    }
}

extension Deck {
    static let empty = Deck(name: "New Deck", pokemons: Card.placeholders.map { $0.name }, background: "forest")
    static let all: [Deck] = try! Bundle.main.decode("decks.json")
}
