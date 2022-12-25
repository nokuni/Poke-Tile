//
//  GameStartAnimationView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 01/03/22.
//

import SwiftUI

struct GameStartAnimationView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @State private var isAnimatingImages = false
    @State private var isAnimatingVersus = false
    @Binding var isPresented: Bool
    var user: User
    var trainer: Trainer
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    if isAnimatingImages {
                        ImageAnimationView(background: trainer.background, image: trainer.image, size: geo.size, insertionEdge: .top, removalEdge: .top)
                    }
                    if isAnimatingImages {
                        ImageAnimationView(background: trainer.background, image: user.profile.image, size: geo.size, insertionEdge: .bottom, removalEdge: .bottom)
                    }
                }
            }
            VersusAnimationView(isAnimating: $isAnimatingVersus)
            ToggableClearView(toggable: $isAnimatingImages)
        }
        .zIndex(2)
        .onAppear {
            withAnimation(.spring()) { isAnimatingImages.toggle() }
            gameVM.animation.start(duration: 2, startAction: nil, whileAction: nil) {
                withAnimation {
                    isAnimatingImages.toggle()
                    isAnimatingVersus.toggle()
                    isPresented.toggle()
                }
            }
        }
    }
}

struct GameStartAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        GameStartAnimationView(isPresented: .constant(false), user: User.previewExample, trainer: Trainer.worldTrainers[0])
    }
}
