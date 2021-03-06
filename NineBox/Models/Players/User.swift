//
//  User.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    var profile: Profile
    var cards = [Card]()
    var decks = [Deck]()
}

extension User {
    static let previewExample = User(profile: Profile())
}
