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
    @ObservedObject var userVM: UserViewModel
    @ObservedObject var adventureVM: AdventureViewModel
    @ObservedObject var homeVM: HomeViewModel
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                if let pages = trainer.pages {
                    if Trainer.getPages(pages)[selectedPageIndex].title != "Important Message" {
                        Image("profOak")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.9)
                            .frame(width: size.width, height: size.height * 0.5)
                            .frame(width: size.width, height: size.height, alignment: .top)
                    }
                }
                VStack {
                    Spacer()
                    TutorialWindowView(trainer: trainer, size: geo.size, selectedPageIndex: $selectedPageIndex, isPresentingTutorial: $isPresentingTutorial, userVM: userVM, adventureVM: adventureVM, homeVM: homeVM)
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(trainer: Trainer.worldTrainers[0], isPresentingTutorial: .constant(false), userVM: UserViewModel(), adventureVM: AdventureViewModel(), homeVM: HomeViewModel())
    }
}

struct TutorialWindowView: View {
    var trainer: Trainer
    var size: CGSize
    @Binding var selectedPageIndex: Int
    @Binding var isPresentingTutorial: Bool
    @ObservedObject var userVM: UserViewModel
    @ObservedObject var adventureVM: AdventureViewModel
    @ObservedObject var homeVM: HomeViewModel
    var body: some View {
        ZStack {
            if let pages = trainer.pages {
                TutorialPageView(trainer: trainer, page: Trainer.getPages(pages)[selectedPageIndex], size: size, userVM: userVM, adventureVM: adventureVM, homeVM: homeVM, selectedPageIndex: $selectedPageIndex, isPresentingTutorial: $isPresentingTutorial)
                    .frame(width: size.width * 0.9, height: size.height * 0.45, alignment: .center)
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
                .padding()
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
