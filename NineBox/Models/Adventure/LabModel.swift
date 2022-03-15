//
//  LabModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI

struct LabModel {
    let title: String
    let image: String
    let color: Color
    var isUnlocked: Bool = false
}

extension LabModel {
    static let tutorials = LabModel(title: "Tutorials", image: "lab.background", color: .grassBorder)
    static let puzzles = LabModel(title: "Puzzles", image: "lab.background", color: .flyingBorder)
    static let all = [tutorials, puzzles]
}
