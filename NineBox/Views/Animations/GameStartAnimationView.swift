//
//  GameStartAnimationView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 01/03/22.
//

import SwiftUI

struct GameStartAnimationView: View {
    @State var isAnimating = false
    //@Binding var isPresented: Bool
    var user: User
    var trainer: Trainer
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            GeometryReader { geo in
                VStack(spacing: 0) {
                    if isAnimating {
                        ZStack {
                            Image(trainer.background)
                                .resizable()
                            Image(trainer.image)
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(0.9)
                                .frame(width: geo.size.width, height: geo.size.height * 0.5)
                        }
                        .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        .ignoresSafeArea()
                    }
                    if isAnimating {
                        ZStack {
                            Image("volcano.background")
                                .resizable()
                            Image(user.profile.image)
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(0.9)
                                .frame(width: geo.size.width, height: geo.size.height * 0.5)
                        }
                        .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                        .ignoresSafeArea()
                    }
                }
            }
            Color.white
                .opacity(0.01)
                .onTapGesture {
                    withAnimation(.spring()) {
                        isAnimating.toggle()
                    }
                }
        }
        .zIndex(2)
        .onAppear {
            withAnimation(.spring()) {
                self.isAnimating.toggle()
            }
        }
    }
}

struct GameStartAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        GameStartAnimationView(user: User.previewExample, trainer: Trainer.trainers[0])
    }
}
