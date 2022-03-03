//
//  StarterBoosterListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct StarterBoosterListView: View {
    var starters: [Booster]
    var size: CGSize
    @Binding var selectedBooster: Booster?
    var body: some View {
        HStack {
            ForEach(starters.indices) { index in
                VStack {
                    PointingArrowView(size: size)
                        .opacity(selectedBooster == starters[index] ? 1 : 0)
                        .padding()
                    Button(action: {
                        selectedBooster = starters[index]
                    }) {
                        CardBoosterView(booster: starters[index], size: size)
                            .shadow(color: selectedBooster == starters[index] ? .white : .clear, radius: 5)
                            .shadow(color: selectedBooster == starters[index] ? .white : .clear, radius: 5)
                    }
                }
            }
        }
    }
}

struct StarterBoosterListView_Previews: PreviewProvider {
    static var previews: some View {
        StarterBoosterListView(starters: [], size: CGSize.screen, selectedBooster: .constant(nil))
    }
}
