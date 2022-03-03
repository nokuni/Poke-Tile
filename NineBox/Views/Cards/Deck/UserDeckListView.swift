//
//  UserDeckListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct UserDeckListView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    @ObservedObject var gameVM: GameViewModel
    @Binding var selectedIndex: Int
    @Binding var selectedDeckIndex: Int
    var size: CGSize
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(gameVM.user.decks) { deck in
                UserDeckRowView(deck: deck, size: size)
            }
        }
    }
}

struct UserDeckListView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckListView(gameVM: GameViewModel(), selectedIndex: .constant(0), selectedDeckIndex: .constant(0), size: CGSize.screen)
    }
}

struct UserDeckRowView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    var deck: Deck
    var size: CGSize
    var body: some View {
        VStack {
            NavigationLink(destination: EmptyView()) {
                LazyVGrid(columns: grid, spacing: 0) {
                    ForEach(deck.cards.indices) { index in
                        CardView(card: deck.cards[index], size: size, amount: 4)
                    }
                }
                .padding(.top, 25)
                .padding(5)
                .background(
                    ZStack {
                        Image(deck.background)
                            .resizable()
                            .centerCropped(radius: 5, alignment: .center)
                        HStack {
                            Text(deck.name)
                                .foregroundColor(.black)
                                .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
                            ForEach(deck.types, id: \.self) { type in
                                Image(type)
                                    .resizable()
                                    .frame(width: size.width * 0.05, height: size.width * 0.05)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            Color.white.cornerRadius(5)
                        )
                        .padding(.horizontal, 8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding(.top, 5)
                    }
                )
            }
        }
    }
}
