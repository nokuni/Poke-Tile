//
//  TutorialWindowView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct TutorialWindowView: View {
    var trainer: Trainer
    var size: CGSize
    @Binding var selectedPageIndex: Int
    @Binding var isPresentingTutorial: Bool
    var body: some View {
        ZStack {
            if let pages = trainer.pages {
                TutorialPageView(trainer: trainer, page: Trainer.getPages(pages)[selectedPageIndex], size: size, selectedPageIndex: $selectedPageIndex, isPresentingTutorial: $isPresentingTutorial)
                    .frame(width: size.width * 0.9, height: size.height * 0.5, alignment: .center)
                    .frame(width: size.width, height: size.height * 0.5, alignment: .center)
                if !Trainer.getPages(pages)[selectedPageIndex].hasAction {
                    PointingArrowView(color: .white, size: size)
                        .frame(width: size.width * 0.85, height: size.height * 0.4, alignment: .bottomTrailing)
                        .frame(width: size.width, height: size.height * 0.4)
                }
            }
        }
        .background(
            Color
                .steelBlue
                .cornerRadius(5)
        )
        .onTapGesture {
            if let pages = trainer.pages {
                if !Trainer.getPages(pages)[selectedPageIndex].hasAction {
                    if selectedPageIndex < (Trainer.getPages(pages).count - 1) {
                        selectedPageIndex += 1
                    }
                }
            }
        }
    }
}

struct TutorialWindowView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialWindowView(trainer: Trainer.tutorialTrainers[0], size: CGSize.screen, selectedPageIndex: .constant(0), isPresentingTutorial: .constant(false))
    }
}
