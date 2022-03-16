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
    @EnvironmentObject var adventureVM: AdventureViewModel
    @EnvironmentObject var homeVM: HomeViewModel
    @State private var selectedDeckIndex = 0
    @State private var selectedIndex = 0
    @State private var isPresentingTutorial = false
    @State var decks = [Deck]()
    var region: WorldRegion?
    var trainer: Trainer
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.preBattle)
                    TrainerRowView(size: geo.size, region: region, background: trainer.background, colorBorder: region?.debuff.borderColor ?? .steelBlue, image: trainer.image, isUnlocked: trainer.isUnlocked, hasBeenCleared: false)
                    if region == nil {
                        TutorialWindowView(trainer: trainer, size: geo.size, selectedPageIndex: $selectedIndex, isPresentingTutorial: $isPresentingTutorial, userVM: userVM, adventureVM: adventureVM, homeVM: homeVM)
                    } else {
                        PreBattleDeckChoiceView(decks: decks, trainer: trainer, size: geo.size, selectedDeckIndex: $selectedDeckIndex, gameVM: gameVM, userVM: userVM)
                    }
                    
                    StartBattleButtonView(trainer: trainer, selectedDeckIndex: selectedDeckIndex, selectedIndex: $selectedIndex, size: geo.size, gameVM: gameVM, userVM: userVM)
                    
                    Spacer()
                    
                    BottomScreenButtonsView(dismiss: dismiss, size: geo.size, isActive: $isActive)
                }
            }
            .padding()
            if adventureVM.tutorialTrainers.allSatisfy({ $0.hasBeenCleared }) && homeVM.isShowingEndingTutorial {
                TutorialView(trainer: try! Trainer.getTutorialTrainer("Ending Prof.Oak"), isPresentingTutorial: $homeVM.isShowingEndingTutorial, userVM: userVM, adventureVM: adventureVM, homeVM: homeVM)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear { decks = userVM.filteredDecks(filter: .playable) }
        .onDisappear { decks.removeAll() }
    }
}

struct PreBattleView_Previews: PreviewProvider {
    static var previews: some View {
        PreBattleView(region: WorldRegion.regions[0], trainer: Trainer.worldTrainers[0], isActive: .constant(false))
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
    }
}

struct TutorialEndView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            
            Image("profOak")
                .resizable()
                .scaledToFit()
        }
    }
}

struct StartBattleButtonView: View {
    var trainer: Trainer
    var selectedDeckIndex: Int
    @Binding var selectedIndex: Int
    var size: CGSize
    @ObservedObject var gameVM: GameViewModel
    @ObservedObject var userVM: UserViewModel
    
    var pageCount: Int {
        guard let pages = trainer.pages else { return 0 }
        let tutorialPages = Trainer.getPages(pages)
        return tutorialPages.count
    }
    var body: some View {
        NavigationLink(destination: GameView()) {
            ActionButtonView(text: "START BATTLE", textColor: .white, color: selectedIndex < (pageCount - 1) ? .gray : .steelBlue, shadowColor: .black, size: size)
        }
        .padding(.vertical)
        .simultaneousGesture(
            TapGesture().onEnded { _ in
                if Trainer.tutorialTrainers.contains(where: { $0.name == trainer.name }) {
                    gameVM.createTutorialGame(trainer: trainer)
                } else {
                    gameVM.createNewGame(trainer: trainer, deck: userVM.filteredDecks(filter: .playable)[selectedDeckIndex])
                }
            }
        )
        .disabled(selectedIndex < (pageCount - 1))
    }
}

struct PreBattleDeckChoiceView: View {
    var decks: [Deck]
    var trainer: Trainer
    var size: CGSize
    @Binding var selectedDeckIndex: Int
    @ObservedObject var gameVM: GameViewModel
    @ObservedObject var userVM: UserViewModel
    var body: some View {
        if !userVM.filteredDecks(filter: .playable).isEmpty {
            UserPreBattleDeckListView(decks: decks, selectedDeckIndex: $selectedDeckIndex, size: size, isPossessing: userVM.isPossessing)
        }
        else {
            Text("You have no playable decks right now")
                .foregroundColor(.gray)
                .font(.system(size: size.width * 0.08, weight: .bold, design: .rounded))
                .frame(width: size.width, height: size.height * 0.2, alignment: .center)
        }
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
