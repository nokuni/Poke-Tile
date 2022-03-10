//
//  CardView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 17/02/2022.
//

import SwiftUI

struct CardView: View {
    var card: Card
    var size: CGSize
    var amount: CGFloat
    var isPossessing: ((Card) -> Bool)?
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(card.borderColor, lineWidth: 3)
            .shadow(color: card.side == .user ? .blue : card.side == .opponent ? .red : .clear, radius: 3)
            .background(
                CardBackgroundView(card: card, isPossessing: isPossessing)
                    .clipped()
            )
            .padding(5)
            .frame(width: size.width * (1/amount), height: size.width * (1/amount))
            .overlay(StatsOverlayView(card: card, amount: amount, size: size, isPossessing: isPossessing))
            .overlay(TypeOverlayView(card: card, amount: amount, size: size))
            .overlay(LegendaryOverlayView(card: card, amount: amount, size: size))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.pokemons[2], size: CGSize.screen, amount: 4)
    }
}

struct StatsOverlayView: View {
    var card: Card
    var amount: CGFloat
    var size: CGSize
    var isPossessing: ((Card) -> Bool)?
    var body: some View {
        ZStack {
            if !(isPossessing?(card) ?? true) {
                EmptyView()
            } else {
                if card.isPokemon {
                    ZStack {
                        StatsView(card: card)
                            .frame(width: size.width * (1/amount), height: size.width * (1/amount), alignment: .topLeading)
                    }
                    .scaleEffect(0.5)
                    .frame(width: size.width * (1.42/amount), height: size.width * (1.42/amount), alignment: .topLeading)
                }
            }
        }
    }
}

struct TypeOverlayView: View {
    var card: Card
    var amount: CGFloat
    var size: CGSize
    var body: some View {
        ZStack {
            if card.isPokemon {
                ZStack {
                    Image(card.backgroundImage)
                        .resizable()
                        .frame(width: size.width * (0.4/amount), height: size.width * (0.4/amount), alignment: .topLeading)
                }
                .scaleEffect(0.5)
                .frame(width: size.width * (1.1/amount), height: size.width * (1.1/amount), alignment: .bottomTrailing)
            }
        }
    }
}

struct LegendaryOverlayView: View {
    var card: Card
    var amount: CGFloat
    var size: CGSize
    var body: some View {
        ZStack {
            if card.isPokemon && card.rarity == .legendary {
                ZStack {
                    Image("legendary")
                        .resizable()
                        .frame(width: size.width * (0.4/amount), height: size.width * (0.4/amount), alignment: .topLeading)
                        .background(Circle().foregroundColor(.white))
                }
                .scaleEffect(0.5)
                .frame(width: size.width * (1.1/amount), height: size.width * (1.1/amount), alignment: .topTrailing)
            }
        }
    }
}
