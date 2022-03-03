//
//  CardPackView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct CardBoosterView: View {
    var booster: Booster
    var size: CGSize
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(booster.type.color, lineWidth: 5)
            .frame(maxWidth: size.width, maxHeight: size.width)
            .background(
                Image(booster.background)
                    .resizable()
                    .centerCropped(radius: 5, alignment: .center)
            )
            .overlay(
                CardBoosterOverlay(booster: booster)
            )
    }
}

struct CardBoosterView_Previews: PreviewProvider {
    static var previews: some View {
        CardBoosterView(booster: Booster.all[1], size: CGSize.screen)
    }
}
