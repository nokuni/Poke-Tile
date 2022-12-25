//
//  UserDeckRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct UserDeckRowView: View {
    var deck: Deck
    var size: CGSize
    var body: some View {
        Image(deck.background)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
            .frame(height: size.height * 0.2)
            .shadow(color: .steelBlue, radius: 0, x: 5, y: 5)
            .padding(.horizontal)
            .overlay(
                UserDeckBackgroundView(deck: deck, size: size)
                    .padding(.horizontal)
            )
            .overlay(
                UserDeckCostView(cost: deck.cost)
                    .padding(.horizontal)
            )
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.steelBlue, lineWidth: 10)
//                    .cornerRadius(5)
//            )
    }
}

struct UserDeckRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckRowView(deck: Deck.empty, size: CGSize.screen)
    }
}

struct UserDeckCostView: View {
    var cost: Int
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.lead)
                .frame(width: CGSize.screen.height * 0.05, height: CGSize.screen.height * 0.05)
            Text("\(cost)")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .frame(maxWidth: CGSize.screen.width, maxHeight: CGSize.screen.height, alignment: .bottomTrailing)
        .padding(5)
    }
}
