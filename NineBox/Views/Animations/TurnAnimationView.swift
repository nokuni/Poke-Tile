//
//  TurnAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TurnAnimationView: View {
    @State var isAnimating = false
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
                        VStack {
                            Text(turn == .opponent ? "\(trainer.name.uppercased())'S TURN" : "YOUR TURN")
                                .foregroundColor(.white)
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                            Image(turn == .opponent ? trainer.image : "blaine")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width, height: geo.size.height * 0.5)
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                    }
                }
            }
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
