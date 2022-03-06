//
//  PreBattleView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct PreBattleView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var gameVM: GameViewModel
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
                    if !gameVM.filteredDecks(filter: .playable).isEmpty {
                        UserPreBattleDeckListView(decks: gameVM.filteredDecks(filter: .playable), selectedDeckIndex: $deckVM.selectedDeckIndex, size: geo.size, isCardInDeck: gameVM.isCardInDeck, isCardPokemon: gameVM.isCardPokemon)
                        
                        NavigationLink(destination: GameView()) {
                            StartBattleButtonView(trainer: trainer, size: geo.size)
                        }
                        .padding(.vertical)
                        .simultaneousGesture(
                            TapGesture().onEnded { _ in
                                gameVM.createNewGame(trainer: trainer, deck: gameVM.filteredDecks(filter: .playable)[deckVM.selectedDeckIndex])
                            }
                        )
                    } else {
                        Text("You have no playable decks right now")
                            .foregroundColor(.gray)
                            .font(.system(size: geo.size.width * 0.08, weight: .bold, design: .rounded))
                            .frame(width: geo.size.width, height: geo.size.height * 0.2, alignment: .center)
                    }
                    
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

struct PreBattleView_Previews: PreviewProvider {
    static var previews: some View {
        PreBattleView(adventure: Adventure.adventures[0], trainer: Trainer.trainers[0])
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
