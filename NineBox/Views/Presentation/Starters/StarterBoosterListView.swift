//
//  StarterBoosterListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct StarterBoosterListView: View {
    var starters: [Booster]
    var size: CGSize
    @Binding var selectedBooster: Booster?
    var body: some View {
        HStack {
            ForEach(starters.indices) { index in
                VStack {
                    PointingArrowView(size: size)
                        .opacity(selectedBooster == starters[index] ? 1 : 0)
                        .padding()
                    Button(action: {
                        selectedBooster = starters[index]
                    }) {
                        CardBoosterView(booster: starters[index], size: size)
                            .shadow(color: selectedBooster == starters[index] ? .white : .clear, radius: 5)
                            .shadow(color: selectedBooster == starters[index] ? .white : .clear, radius: 5)
                    }
                }
            }
        }
    }
}

struct StarterBoosterListView_Previews: PreviewProvider {
    static var previews: some View {
        StarterBoosterListView(starters: [], size: CGSize.screen, selectedBooster: .constant(nil))
    }
}

struct CardBoosterView: View {
    var booster: Booster
    var size: CGSize
    var body: some View {
        Image(booster.background)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .frame(maxWidth: size.width, maxHeight: size.width)
            .overlay(
                CardBoosterOverlay(booster: booster)
            )
    }
}

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
