//
//  TutorialView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 13/03/2022.
//

import SwiftUI

struct TutorialView: View {
    var pages: [TutorialPage]
    var size: CGSize
    var body: some View {
        ZStack {
            TransparentBackgroundView(color: .black)
            TabView {
                ForEach(pages) { page in
                    TutorialPageView(page: page, size: size)
                }
            }
            .tabViewStyle(.page)
            .frame(width: size.width * 0.9, height: size.height * 0.6)
            .background(Color.steelBlue.cornerRadius(5))
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(pages: pages, size: CGSize.screen)
    }
}

struct TransparentBackgroundView: View {
    var color: Color
    var body: some View {
        color
            .opacity(0.5)
            .ignoresSafeArea()
    }
}

struct TutorialPageView: View {
    var page: TutorialPage
    var size: CGSize
    var body: some View {
        VStack(spacing: 0) {
            Text(page.title)
                .font(.system(size: size.width * 0.07, weight: .bold, design: .rounded))
            //Spacer()
            if let image = page.image {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.8)
                    .cornerRadius(5)
            }
            if let card = page.card {
                CardView(card: card, size: size, amount: 1.5, isPossessing: nil)
            }
            Text(page.description)
            Spacer()
        }
        .foregroundColor(.white)
        .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
        .multilineTextAlignment(.center)
        .padding()
    }
}

struct TutorialPage: Identifiable {
    var id = UUID()
    let title: String
    let image: String?
    let card: Card?
    let description: String
}

let pages: [TutorialPage] = [
    TutorialPage(title: "Welcome to the WIP tutorial", image: "invisible", card: nil, description: "Let me remind you how to play this game..."),
    TutorialPage(title: "The Game", image: "forest.background", card: nil, description: "To win, you need to have, on the board, more tiles than your opponent."),
    TutorialPage(title: "Tiles", image: nil, card: try! Card.getPokemon(name: "Pikachu"), description: "This is a Pokemon tile! \n There are 4 numbers on it. \n They represent his power on each side of the board. \n And each tile has his own type, represented at the bottom right."),
    TutorialPage(title: "Stats", image: "tileTutorial00", card: nil, description: "Like this! And the blue color on the card border means that this card is yours."),
    TutorialPage(title: "Conversion", image: "tileTutorial01", card: nil, description: "Your opponent can convert your tile into his own, changing the blue border into red, by playing a card with a higher number on one side."),
    TutorialPage(title: "Re-Conversion", image: "tileTutorial02", card: nil, description: "But don't worry, you can convert it back by playing your own cards."),
    TutorialPage(title: "Tile Debuff", image: "tileTutorial01", card: nil, description: "On the board, there are also debuff tiles,"),
]
