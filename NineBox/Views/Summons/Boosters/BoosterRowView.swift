//
//  BoosterRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct BoosterRowView: View {
    var booster: Booster
    @ObservedObject var userVM: UserViewModel
    var size: CGSize
    var boosterAmount: Int {
        userVM.user.boosters.filter { $0.name == booster.name }.count
    }
    @Binding var selectedBooster: Booster?
    @Binding var cards: [Card]
    @Binding var previousCardCollection: [Card]
    var body: some View {
        HStack {
            CardBoosterView(booster: booster, size: size)
                .frame(height: size.height * 0.2)
            Button(action: {
                selectedBooster = booster
                guard let selectedBooster = selectedBooster else { return }
                userVM.removeBooster(booster)
                let randomCards = selectedBooster.cards.differentRandomElements(amount: 8)
                cards = randomCards
                previousCardCollection = userVM.user.cards
                userVM.addCardsToCollection(cards: cards)
            }) {
                VStack {
                    Text("Open")
                        .font(.system(size: size.width * 0.06, weight: .bold, design: .rounded))
                    HStack {
                        Text("x")
                        Text("\(boosterAmount)")
                            .fontWeight(.black)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .frame(height: size.height * 0.2)
                .background(Color.crimson.cornerRadius(5))
            }
        }
    }
}

struct BoosterRowView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterRowView(booster: Booster.all[0], userVM: UserViewModel(), size: CGSize.screen, selectedBooster: .constant(nil), cards: .constant([]), previousCardCollection: .constant([]))
    }
}
