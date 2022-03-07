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
    @EnvironmentObject var userVM: UserViewModel
    @State var selectedDeckIndex = 0
    @State var selectedIndex = 0
    var adventure: Adventure
    var trainer: Trainer
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.preBattle)
                    TrainerRowView(size: geo.size, adventure: adventure, trainer: trainer)
                    if !userVM.filteredDecks(filter: .playable).isEmpty {
                        UserPreBattleDeckListView(userVM: userVM, selectedDeckIndex: $selectedDeckIndex, size: geo.size, isCardInDeck: userVM.isCardInDeck)
                        
                        NavigationLink(destination: GameView()) {
                            StartBattleButtonView(trainer: trainer, size: geo.size)
                        }
                        .padding(.vertical)
                        .simultaneousGesture(
                            TapGesture().onEnded { _ in
                                gameVM.createNewGame(trainer: trainer, deck: userVM.filteredDecks(filter: .playable)[selectedDeckIndex])
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