//
//  TutorialView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 13/03/2022.
//

import SwiftUI

struct TutorialView: View {
    var size: CGSize = .screen
    @State var selectedPageIndex = 0
    @Binding var isPresentingTutorial: Bool
    @ObservedObject var userVM: UserViewModel
    var body: some View {
        ZStack {
            TransparentBackgroundView(color: .black)
            GeometryReader { geo in
                Image("profOak")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.9)
                    .frame(width: size.width, height: size.height * 0.5)
                    .frame(width: size.width, height: size.height, alignment: .top)
                VStack {
                    Spacer()
                    ZStack {
                        TutorialPageView(page: TutorialPage.all[selectedPageIndex], size: size, userVM: userVM, selectedPageIndex: $selectedPageIndex, isPresentingTutorial: $isPresentingTutorial)
                            .frame(width: size.width * 0.9, height: size.height * 0.55, alignment: .center)
                            .frame(width: size.width, height: size.height * 0.6, alignment: .center)
                        if !TutorialPage.all[selectedPageIndex].hasAction {
                            PointingArrowView(size: geo.size)
                                .frame(width: size.width * 0.85, height: size.height * 0.5, alignment: .bottomTrailing)
                                .frame(width: size.width, height: size.height * 0.4)
                        }
                    }
                    .background(
                        Color
                            .steelBlue
                            .cornerRadius(5)
                            .padding()
                    )
                    .onTapGesture {
                        if !TutorialPage.all[selectedPageIndex].hasAction {
                            selectedPageIndex += 1
                        }
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(isPresentingTutorial: .constant(false), userVM: UserViewModel())
    }
}

struct TransparentBackgroundView: View {
    var color: Color
    var body: some View {
        color
            .opacity(0.5)
            .ignoresSafeArea()
    }
}
