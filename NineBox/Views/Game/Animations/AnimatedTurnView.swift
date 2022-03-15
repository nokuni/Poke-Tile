//
//  AnimatedTurnView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 01/03/22.
//

import SwiftUI

struct AnimatedTurnView: View {
    var user: User
    var trainer: Trainer
    var turn: Turn
    var size: CGSize
    var body: some View {
        VStack {
            Text(turn == .opponent ? "\(trainer.name.uppercased())'S TURN" : "YOUR TURN")
                .foregroundColor(.white)
                .font(.system(size: 40, weight: .bold, design: .rounded))
            Image(turn == .opponent ? trainer.image : user.profile.image)
                .resizable()
                .scaledToFit()
                .frame(width: size.width, height: size.height * 0.5)
        }
        .frame(width: size.width, height: size.height, alignment: .center)
        .transition(AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
    }
}

struct AnimatedTurnView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTurnView(user: User.previewExample, trainer: Trainer.worldTrainers[0], turn: .opponent, size: CGSize.screen)
    }
}
