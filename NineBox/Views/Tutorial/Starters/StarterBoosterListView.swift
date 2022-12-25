//
//  StarterBoosterListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct StarterBoosterListView: View {
    var starters: [Deck]
    var size: CGSize
    @Binding var selectedDeck: Deck?
    var body: some View {
        HStack {
            ForEach(starters.indices, id: \.self) { index in
                VStack {
                    PointingArrowView(color: .white, size: size)
                        .opacity(selectedDeck == starters[index] ? 1 : 0)
                        .padding()
                    Button(action: {
                        selectedDeck = starters[index]
                    }) {
                        CardBoosterView(deck: starters[index], size: size)
                            .shadow(color: selectedDeck == starters[index] ? .white : .clear, radius: 5)
                            .shadow(color: selectedDeck == starters[index] ? .white : .clear, radius: 5)
                    }
                }
            }
        }
    }
}

struct StarterBoosterListView_Previews: PreviewProvider {
    static var previews: some View {
        StarterBoosterListView(starters: [], size: CGSize.screen, selectedDeck: .constant(nil))
    }
}
