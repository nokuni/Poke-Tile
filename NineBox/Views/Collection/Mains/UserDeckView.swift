//
//  UserDeckView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct UserDeckView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userVM: UserViewModel
    @State var filter: DeckFilters = .playable
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.decks)
                    UserDeckFilterView(selectedFilter: $filter)
                    UserDeckListView(decks: userVM.user.decks, size: geo.size, isCardInDeck: userVM.isCardInDeck, isDeckPlayable: userVM.isDeckPlayable)
                    Spacer()
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            userVM.user.decks = userVM.filteredDecks(filter: filter)
        }
        .onChange(of: filter, perform: { newValue in
            userVM.user.decks = userVM.filteredDecks(filter: newValue)
        })
    }
}

struct UserDeckView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckView(userVM: UserViewModel())
    }
}
