//
//  AdventureListView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI

struct AdventureListView: View {
    var size: CGSize
    @Binding var isActive: Bool
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        ScrollView {
            VStack {
                AdventureNavigationLink(adventure: gameVM.adventure.adventures[0], size: size) {
                    JourneyView(isActive: $isActive)
                }
                AdventureNavigationLink(adventure: gameVM.adventure.adventures[1], size: size) {
                    LabView(isActive: $isActive)
                }
            }
        }
    }
}

struct AdventureListView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureListView(size: CGSize.screen, isActive: .constant(false))
    }
}
