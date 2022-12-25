//
//  TutorialView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 13/03/2022.
//

import SwiftUI

struct TutorialView: View {
    var trainer: Trainer
    var size: CGSize = .screen
    @State var selectedPageIndex = 0
    @Binding var isPresentingTutorial: Bool
    var body: some View {
        ZStack {
            Image("lab.background")
                .centerCropped(radius: 5, alignment: .center)
                .ignoresSafeArea()
            GeometryReader { geo in
                if let pages = trainer.pages {
                    if Trainer.getPages(pages)[selectedPageIndex].title != "Important Message" {
                        Image("profOak")
                            .resizable()
                            .scaledToFit()
                            //.scaleEffect(0.9)
                            .frame(width: size.width, height: size.height * 0.4)
                            .frame(width: size.width, height: size.height, alignment: .top)
                    }
                }
                VStack {
                    Spacer()
                    TutorialWindowView(trainer: trainer, size: geo.size, selectedPageIndex: $selectedPageIndex, isPresentingTutorial: $isPresentingTutorial)
                    Color.clear
                        .frame(height: UIScreen.main.bounds.height * 0.28)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(trainer: Trainer.worldTrainers[0], isPresentingTutorial: .constant(false))
    }
}
