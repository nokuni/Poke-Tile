//
//  VersusAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct VersusAnimationView: View {
    @Binding var isAnimating: Bool
    var body: some View {
        ZStack {
            if isAnimating {
                ZStack {
                    Text("VS")
                        .foregroundColor(.white)
                        .font(.system(size: CGSize.screen.width * 0.2, weight: .bold, design: .rounded))
                        .shadow(color: .black, radius: 0, x: 5, y: 5)
                }
                .transition(AnyTransition.scale(scale: 0.5))
            }
        }
        .onAppear {
            withAnimation(.spring()) {
                isAnimating.toggle()
            }
        }
    }
}

struct VersusAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        VersusAnimationView(isAnimating: .constant(false))
    }
}
