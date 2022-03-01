//
//  Theme.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 28/02/2022.
//

import SwiftUI

struct Theme: Identifiable, Hashable {
    var id = UUID()
    let image: String
    let color: Color
}

extension Theme {
    static let pikachu = Theme(image: "pikachu", color: .yellowPikachu)
    static let dragonite = Theme(image: "dragonite", color: .orangeDragonite)
    static let poliwag = Theme(image: "poliwag", color: .bluePoliwag)
    static let totodile = Theme(image: "totodile", color: .blueTotodile)
    static let togepi = Theme(image: "togepi", color: .beigeTogepi)
    
    static let all = [pikachu, dragonite, poliwag, totodile, togepi]
}
