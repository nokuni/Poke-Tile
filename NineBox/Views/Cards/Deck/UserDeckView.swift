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
    @StateObject var deckVM = DeckViewModel()
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.decks)
                    ChangeDeckNameButtonView(isShowingNameAlert: $deckVM.isShowingNameAlert, name: $gameVM.user.decks[deckVM.selectedDeckIndex].name, index: deckVM.selectedDeckIndex)
                    UserDeckListView(gameVM: gameVM, selectedIndex: $deckVM.selectedIndex, selectedDeckIndex: $deckVM.selectedDeckIndex, size: geo.size)
                    UserSetCardListView(size: geo.size, selectedIndex: $deckVM.selectedIndex, selectedCard: $deckVM.selectedCard, selectedDeck: $gameVM.user.decks[deckVM.selectedDeckIndex], gameVM: gameVM)
                        .frame(height: geo.size.height * 0.35)
                    Spacer()
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
            
            if deckVM.isShowingNameAlert {
                ChangeNameAlertModalView(isShowingNameAlert: $deckVM.isShowingNameAlert, name: $gameVM.user.decks[deckVM.selectedDeckIndex].name)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}

struct UserDeckView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckView(gameVM: GameViewModel())
    }
}
