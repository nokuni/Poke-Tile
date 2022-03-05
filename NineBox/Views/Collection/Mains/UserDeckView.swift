//
//  UserDeckView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct UserDeckView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var gameVM: GameViewModel
    @State var filter: DeckFilters = .playable
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.decks)
                    UserDeckFilterView(selectedFilter: $filter)
                    UserDeckListView(cardCollection: gameVM.user.cards, decks: gameVM.filteredDecks(filter: filter), size: geo.size, isCardInDeck: gameVM.isCardInDeck, isDeckPlayable: gameVM.isDeckPlayable)
                    Spacer()
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct UserDeckView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckView(gameVM: GameViewModel())
    }
}
