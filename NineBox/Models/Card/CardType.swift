//
//  CardType.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

enum CardType: String, Codable, Equatable {
    case empty, bug, fire, grass, water, ground
    
    var color: Color {
        switch self {
        case .empty:
            return .black
        case .bug:
            return .bugBorder
        case .fire:
            return .fireBorder
        case .grass:
            return .grassBorder
        case .water:
            return .waterBorder
        case .ground:
            return .groundBorder
        }
    }
}
