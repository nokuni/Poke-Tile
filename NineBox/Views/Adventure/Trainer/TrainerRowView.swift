//
//  TrainerRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TrainerRowView: View {
    var size: CGSize
    var adventure: Adventure
    var trainer: Trainer
    var body: some View {
        ZStack {
            Image(adventure.image)
                .resizable()
                .centerCropped(radius: 5, alignment: .center)
                .padding(5)
                .frame(width: size.width, height: size.height * 0.18)
                .background(
                    adventure.debuff.borderColor
                        .cornerRadius(5)
                )
                .overlay(
                    TrainerImageView(size: size, height: 0.18, image: trainer.image, isUnlocked: trainer.isUnlocked)
                )
        }
    }
}

struct TrainerRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerRowView(size: CGSize.screen, adventure: Adventure.adventures[0], trainer: Trainer.trainers[0])
    }
}
