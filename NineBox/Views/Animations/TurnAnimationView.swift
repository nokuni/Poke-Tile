//
//  TurnAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TurnAnimationView: View {
    @State private var isAnimating = false
    @Binding var isPresented: Bool
    var trainer: Trainer
    var turn: Turn?
    var opponentPlays: (() -> Void)?
    var body: some View {
        if let turn = turn {
            ZStack {
                Color.black.opacity(0.5)
                GeometryReader { geo in
                    if isAnimating {
                        AnimatedTurnView(trainer: trainer, turn: turn, size: geo.size)
                    }
                }
            }
            .zIndex(2)
            .onAppear {
                withAnimation {
                    self.isAnimating.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            self.isAnimating.toggle()
                            self.isPresented.toggle()
                            if turn == .opponent {
                                opponentPlays?()
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct TurnAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TurnAnimationView(isPresented: .constant(false), trainer: Trainer.trainers[0], turn: .opponent)
    }
}
