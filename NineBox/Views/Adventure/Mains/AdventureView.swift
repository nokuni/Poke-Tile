//
//  AdventureView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct AdventureView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.adventure.rawValue)
                    AdventureListView(size: geo.size, isActive: $isActive)
                    Spacer()
                    BottomScreenButtonsView(size: geo.size, isActive: $isActive)
                }
            }
            .spacedScreen
        }
    }
}

struct AdventureView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureView(isActive: .constant(false))
    }
}
