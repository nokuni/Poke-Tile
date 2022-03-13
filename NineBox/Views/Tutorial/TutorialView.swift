//
//  TutorialView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 13/03/2022.
//

import SwiftUI

let pages: [TutorialPage] = [
    TutorialPage(title: "Prof.OAK", image: nil, card: nil, description: "\"Welcome to Pokemon Tiles! \n One the biggest board game in the world of Pokemon!\"", hasAction: false),
    TutorialPage(title: "Prof.OAK", image: nil, card: nil, description: "\"The annual tournament is about to begin and everyone can participate!\"", hasAction: false),
    TutorialPage(title: "Prof.OAK", image: nil, card: nil, description: "While you are here, I can register you. \n But first... \n What is your name?", hasAction: true),
    TutorialPage(title: "Stats", image: "tileTutorial00", card: nil, description: "Like this! And the blue color on the card border means that this card is yours.", hasAction: false),
    TutorialPage(title: "Conversion", image: "tileTutorial01", card: nil, description: "Your opponent can convert your tile into his own, changing the blue border into red, by playing a card with a higher number on one side.", hasAction: false),
    TutorialPage(title: "Re-Conversion", image: "tileTutorial02", card: nil, description: "But don't worry, you can convert it back by playing your own cards.", hasAction: false),
    TutorialPage(title: "Good Luck", image: "025", card: nil, description: "You have now the basis to play. The rest... You need to figure it out yourself, good luck!", hasAction: true),
]

struct TutorialView: View {
    var size: CGSize = .screen
    @State var selectedPageIndex = 0
    var body: some View {
        ZStack {
            TransparentBackgroundView(color: .black)
            
            GeometryReader { geo in
                Image("profOak")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.9)
                    .frame(width: size.width, height: size.height * 0.5)
                    .frame(width: size.width, height: size.height, alignment: .top)
                VStack {
                    Spacer()
                    ZStack {
                        TutorialPageView(page: pages[selectedPageIndex], size: size, selectedPageIndex: $selectedPageIndex)
                            .frame(width: size.width * 0.9, height: size.height * 0.55, alignment: .center)
                            .frame(width: size.width, height: size.height * 0.6, alignment: .center)
                        if selectedPageIndex != 2 {
                        PointingArrowView(size: geo.size)
                            .frame(width: size.width * 0.85, height: size.height * 0.5, alignment: .bottomTrailing)
                            .frame(width: size.width, height: size.height * 0.4)
                        }
                    }
                    .background(
                        Color
                            .steelBlue
                            .cornerRadius(5)
                            .padding()
                    )
                    .onTapGesture {
                        if selectedPageIndex != 2 {
                            selectedPageIndex += 1
                        }
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
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
    @State var text = ""
    var page: TutorialPage
    var size: CGSize
    @Binding var selectedPageIndex: Int
    var body: some View {
        VStack(spacing: 25) {
            Text(page.title)
                .font(.system(size: size.width * 0.08, weight: .bold, design: .rounded))
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
                .font(.system(size: size.width * 0.06, weight: .regular, design: .rounded))
            
            if page.hasAction {
                TextField("Name", text: $text)
                    .padding()
                    .background(Color.teal.cornerRadius(5))
                    .padding()
                
                Button(action: {
                    selectedPageIndex += 1
                }) {
                    Text("OK")
                        .font(.system(size: size.width * 0.07, weight: .bold, design: .rounded))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(text.isEmpty ? .gray : .teal)
                        )
                }
                .disabled(text.isEmpty)
            }
            
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
    let hasAction: Bool
}
