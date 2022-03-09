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
    
    static let shared = UserViewModel()
    
    func addCardsToCollection(cards: [Card]) {
        let newCards = cards.filter { card in
            !user.cards.contains { card.name == $0.name }
        }
        user.cards.append(contentsOf: newCards)
    }
    
    func removeBooster(_ booster: Booster) {
        guard let index = user.boosters.firstIndex(of: booster) else { return }
        user.boosters.remove(at: index)
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
