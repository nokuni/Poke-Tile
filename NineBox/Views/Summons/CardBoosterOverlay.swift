//
//  CardBoosterOverlay.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct CardBoosterOverlay: View {
    var booster: Booster
    var body: some View {
        VStack {
            Text(booster.name.uppercased())
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.white, lineWidth: 3)
                        .background(booster.type.color.cornerRadius(5))
                )
                .multilineTextAlignment(.center)
                .padding(.top)
            Image(booster.type.rawValue)
                .resizable()
                .scaledToFit()
                .padding(5)
                .background(
                    Circle()
                        .foregroundColor(.white)
                )
                .scaleEffect(0.8)
        }
    }
}

struct CardBoosterOverlay_Previews: PreviewProvider {
    static var previews: some View {
        CardBoosterOverlay(booster: Booster.all[0])
    }
}
