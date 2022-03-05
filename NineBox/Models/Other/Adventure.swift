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
    let trainers: [String]
    
    enum CodingKeys: String, CodingKey {
        case title, icon, image, type, trainers
    }
    
    var debuff: Card {
        let debuff = try! Card.getDebuff(name: type)
        return debuff
    }
    
    var realTrainers: [Trainer] {
        return trainers.map { try! Trainer.get($0) }
    }
}

extension Adventure {
    static let adventures: [Adventure] = try! Bundle.main.decode("adventures.json")
}
