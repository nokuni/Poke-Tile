//
//  Adventure.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct WorldRegion: Codable, Identifiable {
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

extension WorldRegion {
    enum WorldRegionError: Error {
        case noRegionFound
    }
    
    static let regions: [WorldRegion] = try! Bundle.main.decode("worldRegions.json")
    
    static func getRegion(title: String) throws -> WorldRegion {
        let regions: [WorldRegion] = try! Bundle.main.decode("worldRegions.json")
        guard let region = regions.first(where: { $0.title == title }) else {
            throw WorldRegionError.noRegionFound
        }
        return region
    }
}
