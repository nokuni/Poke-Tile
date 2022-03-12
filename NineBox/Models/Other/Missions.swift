//
//  Missions.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 12/03/2022.
//

import Foundation

struct Mission: Codable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
    var reward: String
    var isDone: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, description, reward
    }
}

extension Mission {
    static let all: [Mission] = try! Bundle.main.decode("missions.json")
}
