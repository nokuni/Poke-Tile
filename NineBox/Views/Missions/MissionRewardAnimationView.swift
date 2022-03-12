//
//  MissionRewardAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 12/03/2022.
//

import SwiftUI

struct MissionRewardAnimationView: View {
    @State var isAnimating = false
    var card: Card
    var size: CGSize
    @Binding var isShowingRewardView: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack {
                if isAnimating {
                    ZStack {
                        CardView(card: card, size: size, amount: 2, isPossessing: nil)
                    }
                    .transition(AnyTransition.scale)
                }
                
                Button(action: {
                    isShowingRewardView.toggle()
                }) {
                    ActionButtonView(text: "OK", textColor: .white, color: .steelBlue, size: size)
                }
                .padding()
            }
        }
        .onAppear {
            withAnimation(.spring()) {
                isAnimating.toggle()
            }
        }
    }
}

struct MissionRewardAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        MissionRewardAnimationView(card: Card.empty, size: CGSize.screen, isShowingRewardView: .constant(false))
    }
}
