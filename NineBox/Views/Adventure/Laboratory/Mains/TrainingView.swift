//
//  TrainingView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct TrainingView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            switch gameVM.adventure.tutorialTrainerState {
            case .inSelection:
                GeometryReader { geo in
                    VStack(alignment: .leading) {
                        NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.training.rawValue)
                        TrainingTrainersListView(trainers: gameVM.adventure.tutorialTrainers, size: geo.size, isActive: $isActive)
                        Spacer()
                        BottomScreenButtonsView(size: geo.size, isActive: $isActive)
                    }
                }.spacedScreen
            case .inPreBattle:
                if let selectedTrainer = gameVM.adventure.selectedTrainer {
                    PreBattleView(trainer: selectedTrainer)
                }
            case .inBattle:
                GameView()
            case .inEndingTutorial:
                if gameVM.adventure.tutorialTrainers.allSatisfy({ $0.hasBeenCleared }) && gameVM.home.isShowingEndingTutorial {
                    TutorialView(trainer: try! Trainer.getTutorialTrainer("Ending Prof.Oak"), isPresentingTutorial: $gameVM.home.isShowingEndingTutorial)
                }
            }
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView(isActive: .constant(false))
    }
}
