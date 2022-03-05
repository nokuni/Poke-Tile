//
//  PreBattleView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct PreBattleView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var gameVM: GameViewModel
    @StateObject var deckVM = DeckViewModel()
    var adventure: Adventure
    var trainer: Trainer
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.preBattle)
                    TrainerRowView(size: geo.size, adventure: adventure, trainer: trainer)
                    UserPreBattleDeckListView(decks: gameVM.filteredDecks(filter: .playable), selectedDeckIndex: $deckVM.selectedDeckIndex, size: geo.size, isCardInDeck: gameVM.isCardInDeck)
                    
                    Spacer()
                    
                    NavigationLink(destination: GameView()) {
                        StartBattleButtonView(gameVM: gameVM, deckVM: deckVM, trainer: trainer, size: geo.size)
                    }
                    .padding(.vertical)
                    .simultaneousGesture(
                        TapGesture().onEnded { _ in
                            gameVM.createNewGame(trainer: trainer, deck: gameVM.filteredDecks(filter: .playable)[deckVM.selectedDeckIndex])
                        }
                    )
                    
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct PreBattleView_Previews: PreviewProvider {
    static var previews: some View {
        PreBattleView(gameVM: GameViewModel(), adventure: Adventure.adventures[0], trainer: Trainer.trainers[0])
    }
}

//struct UserPreBattleDeckSlotView: View {
//    var cardCollection: [Card]
//    var decks: [Deck]
//    var card: Card
//    var size: CGSize
//    var isCardInDeck: ((Card) -> Bool)?
//    var body: some View {
//        NavigationLink(destination: UserDeckView(cardCollection: cardCollection, decks: decks)) {
//            CardView(card: card, size: size, amount: 4, isCardInDeck: isCardInDeck)
//        }
//    }
//}
