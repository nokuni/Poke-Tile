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
    var trainerName: String
    var adventure: Adventure
    var trainer: Trainer {
        return try! Trainer.get(trainerName)
    }
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.preBattle)
                TrainerRowView(size: geo.size, adventure: adventure, trainer: trainer)
                Text(gameVM.user.decks[deckVM.selectedDeckIndex].name)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color.steelBlue
                            .cornerRadius(5)
                    )
                UserPreBattleDeckListView(gameVM: gameVM, selectedDeckIndex: $deckVM.selectedDeckIndex, size: geo.size)
                
                Spacer()
                
                if !gameVM.isDeckReady(index: deckVM.selectedDeckIndex) {
                    Text("Your deck needs 8 cards")
                        .foregroundColor(.red)
                }
                NavigationLink(destination: GameView()) {
                    Text("START BATTLE")
                        .foregroundColor(.black)
                        .font(.system(size: geo.size.width * 0.05, weight: .bold, design: .rounded))
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(!gameVM.isDeckReady(index: deckVM.selectedDeckIndex) ? . gray : .yellow)
                                .cornerRadius(5)
                                .shadow(color: .black, radius: 0, x: 3, y: 3)
                        )
                }
                .padding(.vertical)
                .simultaneousGesture(
                    TapGesture().onEnded { _ in
                        gameVM.createNewGame(trainer: trainer, deck: gameVM.user.decks[deckVM.selectedDeckIndex])
                    }
                )
                .disabled(!gameVM.isDeckReady(index: deckVM.selectedDeckIndex))
                
                BackButtonView(size: geo.size, dismiss: dismiss)
            }
        }
        .padding()
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct PreBattleView_Previews: PreviewProvider {
    static var previews: some View {
        PreBattleView(gameVM: GameViewModel(), trainerName: "Erika", adventure: Adventure.adventures[0])
    }
}

struct UserPreBattleDeckSlotView: View {
    @ObservedObject var gameVM: GameViewModel
    var card: Card
    var size: CGSize
    var body: some View {
        NavigationLink(destination: UserDeckView(gameVM: gameVM)) {
            CardView(card: card, size: size, amount: 4)
        }
    }
}

struct UserPreBattleDeckListView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    @ObservedObject var gameVM: GameViewModel
    @Binding var selectedDeckIndex: Int
    var size: CGSize
    var body: some View {
        TabView(selection: $selectedDeckIndex) {
            ForEach(gameVM.user.decks.indices) { deckIndex in
                LazyVGrid(columns: grid, spacing: 0) {
                    ForEach(gameVM.user.decks[deckIndex].cards.indices) { index in
                        UserPreBattleDeckSlotView(gameVM: gameVM, card: gameVM.user.decks[deckIndex].cards[index], size: size)
                    }
                }
                .tag(deckIndex)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: size.width, height: size.height * 0.25)
    }
}
