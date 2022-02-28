//
//  StatSquareView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct StatSquareView: View {
    var size: CGSize
    var index: Int
    var card: Card
    private var stat: Int {
        switch true {
        case index == 1:
            return card.stats.top
        case index == 3:
            return card.stats.leading
        case index == 5:
            return card.stats.trailing
        case index == 7:
            return card.stats.bottom
        default:
            return 0
        }
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.white)
                .frame(width: size.width * (1/3), height: size.width * (1/3))
                .background(
                    Color.white
                        .cornerRadius(5)
                        .opacity(0.8))
            Text("\(stat)")
                .foregroundColor(.black)
                .font(.system(size: size.width * 0.25, weight: .bold, design: .rounded))
                //.brightness(-0.2)
        }
        .opacity(!index.isMultiple(of: 2) ? 1 : 0)
    }
}

struct StatSquareView_Previews: PreviewProvider {
    static var previews: some View {
        StatSquareView(size: CGSize.screen, index: 0, card: Card.pokemons[0])
    }
}
