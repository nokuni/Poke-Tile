//
//  QuitTutorialView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI

struct QuitTutorialView: View {
    var page: TutorialPage
    var size: CGSize
    @Binding var isPresentingTutorial: Bool
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        if page.isQuitting != nil {
            Button(action: {
                isPresentingTutorial.toggle()
                if page.title == "Important Message" {
                    gameVM.home.unlock("Decks")
                    gameVM.home.unlock("Cards")
                    gameVM.home.unlock("Missions")
                    gameVM.adventure.unlockAdventure("World")
                    gameVM.adventure.tutorialTrainerState = .inSelection
                    gameVM.game = Game()
                }
            }) {
                Text("Quit")
                    .font(.system(size: size.width * 0.07, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .strokeText(color: .steelBlue)
                    .padding(5)
                    .frame(width: size.width * 0.82)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.mediumBlueApp)
                            .strokeText(color: .steelBlue)
                    )
            }
        }
    }
}

struct QuitTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        QuitTutorialView(page: TutorialPage.example, size: CGSize.screen, isPresentingTutorial: .constant(false))
    }
}
