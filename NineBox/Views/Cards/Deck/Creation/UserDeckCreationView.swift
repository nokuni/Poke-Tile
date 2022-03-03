//
//  UserDeckCreationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 02/03/2022.
//

import SwiftUI

struct UserDeckCreationView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var gameVM: GameViewModel
    @StateObject var deckVM = DeckViewModel()
    @State var cards = Card.placeholders
    @State var selectedIndex = 0
    @State var selectedCard: Card? = nil
    @State var placeholderName = "New Deck"
    @State var isShowingNameAlert = false
    var size: CGSize
    var deck: Deck {
        let cardNames = cards.map { $0.name }
        return Deck(name: placeholderName, pokemons: cardNames, background: "forest.background")
    }
    var isDeckFilled: Bool {
        cards.allSatisfy({ $0.category == .pokemon })
    }
    var isCostRight: Bool {
        return deck.cost <= 50
    }
    var canCreateDeck: Bool {
        isCostRight && isDeckFilled
    }
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.deckCreation)
                    ChangeDeckNameButtonView(isShowingNameAlert: $isShowingNameAlert, name: $placeholderName)
                    UserDeckPlaceholderView(cards: $cards, selectedIndex: $selectedIndex)
                    Text("\(deck.cost)")
                    UserSetCardListView(size: geo.size, selectedIndex: $selectedIndex, selectedCard: $selectedCard, cards: $cards, gameVM: gameVM)
                        .frame(height: geo.size.height * 0.35)
                    Button(action: {
                        gameVM.user.decks.insert(deck, at: 0)
                        dismiss()
                    }) {
                        LongButtonView(text: "Create", textColor: .white, backgroundColor: !canCreateDeck ? .gray : .limeGreen, borderColor: .black)
                    }
                    .disabled(!canCreateDeck)
                    
                    Spacer()
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
            
            if isShowingNameAlert {
                ChangeNameAlertModalView(isShowingNameAlert: $isShowingNameAlert, name: $placeholderName)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}

struct UserDeckCreationView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckCreationView(gameVM: GameViewModel(), size: CGSize.screen)
    }
}
