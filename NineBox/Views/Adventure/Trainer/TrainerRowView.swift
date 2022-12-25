//
//  TrainerRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TrainerRowView: View {
    var size: CGSize
    var region: WorldRegion?
    var background: String
    var colorBorder: Color
    var image: String
    var isUnlocked: Bool
    var hasBeenCleared: Bool
    var body: some View {
        ZStack {
            Image(background)
                .resizable()
                .centerCropped(radius: 5, alignment: .center)
                .padding(5)
                .frame(width: size.width, height: size.height * 0.18)
                .background(
                    colorBorder
                        .cornerRadius(5)
                )
                .overlay(
                    TrainerImageView(size: size, height: 0.167, image: image, isUnlocked: isUnlocked, hasBeenCleared: hasBeenCleared)
                )
                .overlay(
                    TrainerRowOverlayView(isUnlocked: isUnlocked, size: size)
                )
        }
    }
}

struct TrainerRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerRowView(size: CGSize.screen, region: WorldRegion.regions[0], background: "forest.background", colorBorder: .steelBlue, image: "", isUnlocked: false, hasBeenCleared: false)
    }
}
