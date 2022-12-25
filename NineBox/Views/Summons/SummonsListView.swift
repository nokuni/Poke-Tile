//
//  SummonsListView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct SummonsListView: View {
    var packs: [Color]
    @Binding var selectedSummonPackIndex: Int
    var body: some View {
        TabView(selection: $selectedSummonPackIndex) {
            ForEach(packs.indices, id: \.self) { index in
                SummonPageView(color: packs[index])
                    .tag(index)
            }
        }
        .allowsHitTesting(false)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .padding()
    }
}

struct SummonsListView_Previews: PreviewProvider {
    static var previews: some View {
        SummonsListView(packs: [], selectedSummonPackIndex: .constant(0))
    }
}
