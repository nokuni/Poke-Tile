//
//  PreBattleView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct PreBattleView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @State private var selectedDeckIndex = 0
    @State private var selectedIndex = 0
    @State private var isPresentingTutorial = false
    @State var decks = [Deck]()
    var region: WorldRegion?
    var trainer: Trainer
    //@Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.preBattle.rawValue)
                    
                    TrainerRowView(size: geo.size, region: region, background: trainer.background, colorBorder: region?.debuff.borderColor ?? .steelBlue, image: trainer.image, isUnlocked: trainer.isUnlocked, hasBeenCleared: false)
                    
                    if region == nil {
                        TutorialWindowView(trainer: trainer, size: geo.size, selectedPageIndex: $selectedIndex, isPresentingTutorial: $isPresentingTutorial)
                    } else {
                        PreBattleDeckChoiceView(decks: decks, trainer: trainer, size: geo.size, selectedDeckIndex: $selectedDeckIndex)
                    }
                    
                    StartBattleButtonView(selectedIndex: $selectedIndex, region: region, trainer: trainer, selectedDeckIndex: selectedDeckIndex, size: geo.size)
                    
                    Spacer()
                    
                    Button(action: {
                        gameVM.adventure.worldTrainerState = .inSelection
                        gameVM.adventure.tutorialTrainerState = .inSelection
                        gameVM.game = Game()
                    }) {
                        ActionButtonView(text: "CLOSE", textColor: .white, textSize: 0.025, textStrokeColor: .maroon, buttonColor: .crimson, buttonStrokeColor: .maroon)
                    }
                    
                    //BottomScreenButtonsView(size: geo.size, isActive: $isActive)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear { decks = gameVM.user.filteredDecks(filter: .playable) }
        .onDisappear { decks.removeAll() }
    }
}

struct PreBattleView_Previews: PreviewProvider {
    static var previews: some View {
        PreBattleView(region: WorldRegion.regions[0], trainer: Trainer.worldTrainers[0])
            .environmentObject(GameViewModel())
    }
}
