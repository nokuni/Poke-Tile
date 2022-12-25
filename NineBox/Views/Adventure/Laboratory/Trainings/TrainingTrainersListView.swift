//
//  TrainingTrainersListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI

enum TutorialTrainerState {
    case inSelection, inPreBattle, inBattle, inEndingTutorial
}

enum WorldTrainerState {
    case inSelection, inPreBattle, inBattle
}

struct TrainingTrainersListView: View {
    @State var selection: UUID?
    var trainers: [Trainer]
    var size: CGSize
    @Binding var isActive: Bool
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        ScrollView {
            VStack {
                ForEach(trainers) { trainer in
                    Button(action: {
                        if trainer.isUnlocked {
                            gameVM.adventure.selectedTrainer = trainer
                            gameVM.adventure.tutorialTrainerState = .inPreBattle
                            gameVM.game = Game()
                        }
                    }) {
                        TrainerRowView(size: size, background: trainer.background, colorBorder: .flyingBorder, image: trainer.image, isUnlocked: trainer.isUnlocked, hasBeenCleared: trainer.hasBeenCleared)
                    }
                }
            }
        }
    }
}

struct TrainingTrainersListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingTrainersListView(trainers: [], size: CGSize.screen, isActive: .constant(false))
    }
}

//NavigationLink(destination: PreBattleView(trainer: trainer, isActive: $isActive)) {
//    TrainerRowView(size: size, background: trainer.background, colorBorder: .flyingBorder, image: trainer.image, isUnlocked: trainer.isUnlocked, hasBeenCleared: trainer.hasBeenCleared)
//}
//.disabled(!trainer.isUnlocked)

/*NavigationLink(
    destination: PreBattleView(trainer: trainer, isActive: $isActive),
    tag: trainer.id,
    selection: $selection,
    label: {
        TrainerRowView(size: size, background: trainer.background, colorBorder: .flyingBorder, image: trainer.image, isUnlocked: trainer.isUnlocked, hasBeenCleared: trainer.hasBeenCleared)
    })
.disabled(!trainer.isUnlocked)*/
