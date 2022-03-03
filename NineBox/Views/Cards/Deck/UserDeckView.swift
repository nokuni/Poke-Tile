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
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.decks)
                    NavigationLink(destination: UserDeckCreationView(gameVM: gameVM, deckVM: deckVM, size: geo.size)) {
                        LongButtonView(text: "Create New Deck", textColor: .white, backgroundColor: .limeGreen, borderColor: .black)
                    }
                    UserDeckListView(gameVM: gameVM, selectedIndex: $deckVM.selectedIndex, selectedDeckIndex: $deckVM.selectedDeckIndex, size: geo.size)
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
