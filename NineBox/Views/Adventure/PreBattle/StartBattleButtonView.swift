//
//  StartBattleButtonView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct StartBattleButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var gameVM: GameViewModel
    @Binding var selectedIndex: Int
    var region: WorldRegion?
    var trainer: Trainer
    var selectedDeckIndex: Int
    var size: CGSize
    var pageCount: Int {
        guard let pages = trainer.pages else {
            print("trainer pages is NULL")
            return 0
        }
        let tutorialPages = Trainer.getPages(pages)
        return tutorialPages.count
    }
    var body: some View {
        Button(action: {
            switch true {
            case region == nil:
                let isTutorialExplanationFinished = selectedIndex == (pageCount - 1)
                let isTutorialTrainer = Trainer.tutorialTrainers.contains(where: { $0.name == trainer.name })
                if isTutorialExplanationFinished && isTutorialTrainer {
                    gameVM.adventure.tutorialTrainerState = .inBattle
                    gameVM.resetGame()
                    gameVM.createTutorialGame(trainer: trainer)
                }
            default:
                gameVM.adventure.worldTrainerState = .inBattle
                gameVM.resetGame()
                gameVM.createNewGame(trainer: trainer, deck: gameVM.user.filteredDecks(filter: .playable)[selectedDeckIndex])
            }
        }) {
            ActionButtonView(text: "START BATTLE", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: selectedIndex < (pageCount - 1) ? .gray : .orangeApp, buttonStrokeColor: .steelBlue)
        }
        .padding(.vertical)
    }
}

struct StartBattleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartBattleButtonView(selectedIndex: .constant(0), trainer: Trainer.tutorialTrainers[0], selectedDeckIndex: 0, size: CGSize.screen)
    }
}
