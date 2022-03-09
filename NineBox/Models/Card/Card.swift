//
//  Card.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/02/2022.
//

import Foundation
import SwiftUI

enum CardRarity: String, Codable, Hashable {
    case none, common, uncommon, rare, epic, legendary
    
    var rate: Int {
        switch self {
        case .none:
            return 0
        case .common:
            return 40
        case .uncommon:
            return 30
        case .rare:
            return 20
        case .epic:
            return 10
        case .legendary:
            return 5
        }
    }
}

struct Card: Equatable, Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    var image: String
    var backgroundImage: String
    var category: CardCategory
    var type: CardType
    var stats: Stats
    var rarity: CardRarity
    var cost: Int
    var debuffs = [String]()
    var isActivated: Bool = true
    var side: CardSide? = nil
    
    enum CodingKeys: String, CodingKey {
        case name, image, backgroundImage, category, type, stats, rarity, cost
    }
    
    var borderColor: Color {
        if let side = side { return side.color } else { return type.color }
    }
    
    var isPokemon: Bool { category == .pokemon }
    var isUserSide: Bool { side == .user }
    var isDebuff: Bool { category == .debuff }
    var isAvailable: Bool { category == .empty }
    
    func isDuplicate(from cards: [Card]) -> Bool {
        cards.contains { $0.name == name }
    }
    
    func buffed(with debuff: Card) -> Card {
        var card = self
        let count = debuff.debuffs.count
        let buffAmount = card.type == debuff.type ? count : -count
        card.stats.top += buffAmount
        card.stats.trailing += buffAmount
        card.stats.bottom += buffAmount
        card.stats.leading += buffAmount
        return card
    }
}

extension Card {
    enum CardError: Error {
        case noPokemonFound
        case noDebuffFound
    }
    
    static let slot = Card(name: "Slot", image: "add", backgroundImage: "spiral", category: .empty, type: .empty, stats: .init(top: 0, trailing: 0, bottom: 0, leading: 0), rarity: .common, cost: 0, debuffs: [])
    static let empty = Card(name: "Empty", image: "pokeball", backgroundImage: "spiral", category: .empty, type: .empty, stats: .init(top: 0, trailing: 0, bottom: 0, leading: 0), rarity: .none, cost: 0, debuffs: [])
    static let invisible = Card(name: "Invisible", image: "invisible", backgroundImage: "invisible", category: .empty, type: .empty, stats: .init(top: 0, trailing: 0, bottom: 0, leading: 0), rarity: .none, cost: 0)
    
    static let placeholders = Array(repeating: Card.empty, count: 8)
    static let emptyBoard = Array(repeating: Card.invisible, count: 16)
    
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

