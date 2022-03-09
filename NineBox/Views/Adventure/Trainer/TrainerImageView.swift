//
//  TrainerBackgroundView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 21/02/2022.
//

import SwiftUI

struct TrainerImageView: View {
    var size: CGSize
    var height: CGFloat
    var image: String
    var isUnlocked: Bool
    var hasBeenCleared: Bool
    var body: some View {
        Image(image)
            .resizable()
            .renderingMode(isUnlocked ? .none : .template)
            .centerCropped(radius: 0, alignment: .top)
            .foregroundColor(.black)
            .frame(width: size.width * 0.4, height: size.height * height, alignment: .leading)
            .frame(width: size.width, height: size.height * 0.18, alignment: .leading)
            .overlay(
                Text(hasBeenCleared ? "CLEARED" : "")
                    .foregroundColor(.white)
                    .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
                    .frame(width: size.width * 0.7, alignment: .trailing)
                    .shadow(color: .black, radius: 0, x: 2, y: 2)
            )
    }
}

struct TrainerImageView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerImageView(size: CGSize.screen, height: 0.18, image: "erika", isUnlocked: false, hasBeenCleared: false)
    }
}
