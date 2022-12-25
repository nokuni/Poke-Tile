//
//  LabView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct LabView: View {
    @Binding var isActive: Bool
    @EnvironmentObject var gameVM: GameViewModel
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.lab.rawValue)
                    LabListView(size: geo.size, isActive: $isActive)
                    Spacer()
                    BottomScreenButtonsView(size: geo.size, isActive: $isActive)
                }
            }
            .spacedScreen
        }
    }
}

struct LabView_Previews: PreviewProvider {
    static var previews: some View {
        LabView(isActive: .constant(false))
    }
}
