//
//  UserViewModel.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 07/03/2022.
//

import SwiftUI

// Card Collection, Boosters, Summons and Decks

class UserViewModel: ObservableObject {
    @Published var user = User(profile: Profile(name: "Nokuni", image: "userboy"))
    
    init() { }
    
    static let shared = UserViewModel()
    
    func addCardsToCollection(_ cards: [Card]) {
        user.cards.append(contentsOf: cards)
    }
    
    func isPossessing(_ card: Card) -> Bool {
        user.cards.contains(where: { $0.name == card.name })
    }
    
    func isDeckPlayable(deck: Deck) -> Bool {
        var boolArray = [Bool]()
        for card in deck.cards {
            if isPossessing(card) { boolArray.append(true) } else { boolArray.append(false) }
        }
        return boolArray.allSatisfy({ $0 == true })
    }
    
    func filteredDecks(filter: DeckFilters) -> [Deck] {
        switch filter {
        case .all:
            return Deck.all
        case .playable:
            return Deck.all.filter { isDeckPlayable(deck: $0) }
        }
    }
}
