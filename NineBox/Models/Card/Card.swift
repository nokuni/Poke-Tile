//
//  Card.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/02/2022.
//

import Foundation
import SwiftUI

enum CardRarity: String, Codable {
    case none, common, uncommon, rare, epic, legendary
}

struct Card: Equatable, Codable, Identifiable {
    var id = UUID()
    let name: String
    var image: String
    var backgroundImage: String
    var category: CardCategory
    var type: CardType
    var stats: Stats
    var rarity: CardRarity
    var cost: Int
    var debuffAmount: Int? = nil
    var isActivated: Bool = true
    var side: CardSide? = nil
    
    enum CodingKeys: String, CodingKey {
        case name, image, backgroundImage, category, type, stats, rarity, cost
    }
    
    var borderColor: Color {
        if let side = side { return side.color } else { return type.color }
    }
}

extension Card {
    enum CardError: Error {
        case noPokemonFound
        case noDebuffFound
    }
    
    static let slot = Card(name: "Slot", image: "add", backgroundImage: "spiral", category: .empty, type: .empty, stats: .init(top: 0, trailing: 0, bottom: 0, leading: 0), rarity: .common, cost: 0, debuffAmount: nil)
    static let empty = Card(name: "Empty", image: "pokeball", backgroundImage: "spiral", category: .empty, type: .empty, stats: .init(top: 0, trailing: 0, bottom: 0, leading: 0), rarity: .common, cost: 0, debuffAmount: nil)
    static let placeholders = Array(repeating: Card.empty, count: 8)
    
    static let debuffs: [Card] = try! Bundle.main.decode("debuffs.json")
    static let pokemons: [Card] = try! Bundle.main.decode("pokemons.json")
    
    static func getPokemon(name: String) throws -> Card {
        let pokemons: [Card] = try! Bundle.main.decode("pokemons.json")
        guard let pokemon = pokemons.first(where: { $0.name == name }) else {
            throw CardError.noPokemonFound
        }
        return pokemon
    }
    static func getDebuff(name: String) throws -> Card {
        let debuffs: [Card] = try! Bundle.main.decode("debuffs.json")
        guard let debuff = debuffs.first(where: { $0.name == name }) else {
            throw CardError.noDebuffFound
        }
        return debuff
    }
    static func getDebuff(type: CardType) throws -> Card {
        let debuffs: [Card] = try! Bundle.main.decode("debuffs.json")
        guard let debuff = debuffs.first(where: { $0.type == type }) else {
            throw CardError.noDebuffFound
        }
        return debuff
    }
}

//static let dark = Card(image: "dark", backgroundImage: "dark", category: .debuff, type: .dark, stats: nil)
//static let dragon = Card(image: "dragon", backgroundImage: "dragon", category: .debuff, type: .dragon, stats: nil)
//static let electric = Card(image: "electric", backgroundImage: "electric", category: .debuff, type: .electric, stats: nil)

