//
//  Deck.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import Foundation

struct Deck: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    let associatedType: CardType
    var pokemons: [String]
    var background: String
    
    enum CodingKeys: String, CodingKey {
        case name, associatedType, pokemons, background
    }
    
    var cards: [Card] {
        let filteredPokemons = pokemons.filter { $0 != "Empty" }
        let result = filteredPokemons.map { try! Card.getPokemon(name: $0) }
        return result
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
    static let empty = Deck(name: "New Deck", associatedType: .empty, pokemons: Card.placeholders.map { $0.name }, background: "forest")
    static let all: [Deck] = try! Bundle.main.decode("decks.json")
    static let trainerDecks = Trainer.worldTrainers.map { Deck(name: "\($0.name)'s Deck", associatedType: $0.associatedType ?? .empty, pokemons: $0.pokemons, background: $0.background) }
    static let starters = all.filter({ $0.name.contains("Starter")})
}

enum DeckFilters: String, CaseIterable {
    case all, playable
}
