//
//  SummonsView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct SummonsView: View {
    let animation = ChainAnimation()
    @State private var canPressButton: Bool = true
    @State private var selectedSummonPackIndex: Int = 0
    let packs: [Color] = [.green, .yellow, .orange]
    var body: some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
            
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.summons.rawValue)
                        .padding(.leading)
                        .padding(.top)
                    
                    SummonsListView(packs: packs, selectedSummonPackIndex: $selectedSummonPackIndex)
                    
                    PagingButtonsView(collection: packs, canPressButton: $canPressButton, index: $selectedSummonPackIndex)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    BackButtonView(size: geo.size)
                        .padding()
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SummonsView_Previews: PreviewProvider {
    static var previews: some View {
        SummonsView()
    }
}
