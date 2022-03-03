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
    var size: CGSize
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(gameVM.user.decks) { deck in
                UserDeckRowView(gameVM: gameVM, deck: deck, size: size)
            }
        }
    }
}

struct UserDeckListView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckListView(gameVM: GameViewModel(), size: CGSize.screen)
    }
}
