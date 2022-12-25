//
//  TurnAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TurnAnimationView: View {
    let animation = ChainAnimation()
    @State private var isAnimating = false
    @Binding var isPresented: Bool
    var user: User
    var trainer: Trainer
    var turn: Turn?
    var opponentPlays: (() -> Void)?
    var body: some View {
        if let turn = turn {
            ZStack {
                Color.black.opacity(0.5)
                GeometryReader { geo in
                    if isAnimating {
                        AnimatedTurnView(user: user, trainer: trainer, turn: turn, size: geo.size)
                    }
                }
            }
            .zIndex(2)
            .onAppear {
                animation.start(duration: 1, startAction: {
                    withAnimation { self.isAnimating.toggle() }
                }, whileAction: nil) {
                    withAnimation {
                        self.isAnimating.toggle()
                        self.isPresented.toggle()
                        if turn == .opponent { opponentPlays?() }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct TurnAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TurnAnimationView(isPresented: .constant(false), user: User.previewExample, trainer: Trainer.worldTrainers[0], turn: .opponent)
    }
}
