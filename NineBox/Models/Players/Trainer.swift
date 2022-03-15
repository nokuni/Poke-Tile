//
//  Trainer.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 21/02/2022.
//

import SwiftUI

struct Trainer: Codable, Identifiable, Equatable {
    var id = UUID()
    let name: String
    let image: String
    let background: String
    let associatedType: CardType
    var pokemons: [String]
    let bonusLocations: [Int]
    let difficulty: GameDifficulty
    let reward: String
    var isUnlocked: Bool = false
    var hasBeenCleared: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, image, background, associatedType, pokemons, bonusLocations, difficulty, reward
    }
    
    var cards: [Card] {
        return pokemons.map { try! Card.getPokemon(name: $0) }
    }
    
    var colors: [Color] {
        let types = Set(cards.compactMap { $0.type })
        return types.map { $0.color }
    }
}

extension Trainer {
    enum TrainerError: Error {
        case noTrainer
        case noBooster
    }
    static let trainers: [Trainer] = try! Bundle.main.decode("trainers.json")
    
    static func getTrainer(_ name: String) throws -> Trainer {
        let trainers: [Trainer] = try! Bundle.main.decode("trainers.json")
        guard let trainer = trainers.first(where: { $0.name == name }) else {
            throw TrainerError.noTrainer
        }
        return trainer
    }
}
