//
//  AdventureView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct JourneyView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.world.rawValue)
                    RegionsListView(regions: gameVM.adventure.regions, size: geo.size, isActive: $isActive)
                    Spacer()
                    BottomScreenButtonsView(size: geo.size, isActive: $isActive)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct JourneyView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyView(isActive: .constant(false))
    }
}
