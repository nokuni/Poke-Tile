//
//  Adventure.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct Adventure: Codable, Identifiable {
    var id = UUID()
    let title: String
    let icon: String
    let image: String
    let type: String
    let trainerNames: [String]
    var trainers = [Trainer]()
    
    enum CodingKeys: String, CodingKey {
        case title, icon, image, type, trainerNames
    }
    
    var debuff: Card {
        let debuff = try! Card.getDebuff(name: type)
        return debuff
    }
}

extension Adventure {
    enum AdventureError: Error {
        case noAdventureFound
    }
    static let adventures: [Adventure] = try! Bundle.main.decode("adventures.json")
    
    static func getAdventure(title: String) throws -> Adventure {
        let adventures: [Adventure] = try! Bundle.main.decode("adventures.json")
        guard let adventure = adventures.first(where: { $0.title == title }) else {
            throw AdventureError.noAdventureFound
        }
        return adventure
    }
}
