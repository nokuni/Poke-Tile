//
//  AdventureModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI

struct AdventureModel {
    let title: String
    let image: String
    let color: Color
    var isUnlocked: Bool = false
}

extension AdventureModel {
    static let world = AdventureModel(title: "World", image: "world.background", color: .grassBorder)
    static let lab = AdventureModel(title: "Lab", image: "lab.background", color: .flyingBorder)
    static let all = [world, lab]
}
