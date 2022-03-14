//
//  Tutorial.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 14/03/22.
//

import Foundation

struct TutorialPage: Identifiable, Codable {
    var id = UUID()
    let title: String
    let images: [String]?
    let description: String
    var hasAction: Bool
    var isChoosingGenre: Bool?
    var isChoosingName: Bool?
    var isQuitting: Bool?
    
    enum CodingKeys: String, CodingKey {
        case title, images, description, hasAction, isChoosingGenre, isChoosingName, isQuitting
    }
    
}

extension TutorialPage {
    static let all: [TutorialPage] = try! Bundle.main.decode("tutorial.json")
}
