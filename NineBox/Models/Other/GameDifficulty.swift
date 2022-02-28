//
//  GameDifficulty.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 21/02/2022.
//

import SwiftUI

enum GameDifficulty: String, Codable {
    case easy, normal, hard, veryHard, challenge
    
    var color: Color {
        switch self {
        case .easy:
            return .green
        case .normal:
            return .yellow
        case .hard:
            return .orange
        case .veryHard:
            return .red
        case .challenge:
            return .black
        }
    }
}
