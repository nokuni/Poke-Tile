//
//  Booster.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import Foundation

struct Booster: Codable, Equatable {
    var name: String
    var cardPool: [String]
    var background: String
    var type: CardType
    
    var cards: [Card] {
        return cardPool.map { try! Card.getPokemon(name: $0) }
    }
}

extension Booster {
    static let all: [Booster] = try! Bundle.main.decode("boosters.json")
    static let starters = Booster.all.filter { $0.name.contains("Starter") }
}
