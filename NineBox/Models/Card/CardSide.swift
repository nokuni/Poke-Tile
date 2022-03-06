//
//  CardSide.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

enum CardSide: String, Codable, Hashable {
    case user, opponent
    
    var color: Color {
        switch self {
        case .user:
            return .deepSky
        case .opponent:
            return .crimson
        }
    }
}
