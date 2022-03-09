//
//  UserCardInformationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 05/03/2022.
//

import SwiftUI

struct UserCardInformationView: View {
    var card: Card
    var size: CGSize
    var isPossessing: ((Card) -> Bool)?
    var body: some View {
        CardView(card: card, size: size, amount: 1, isPossessing: isPossessing)
    }
}

struct UserCardInformationView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardInformationView(card: Card.empty, size: CGSize.screen)
    }
}
