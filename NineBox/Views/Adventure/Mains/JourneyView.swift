//
//  AdventureView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct JourneyView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var adventureVM: AdventureViewModel
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: .world)
                    RegionsListView(regions: adventureVM.regions, size: geo.size, isActive: $isActive)
                    Spacer()
                    BottomScreenButtonsView(dismiss: dismiss, size: geo.size, isActive: $isActive)
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
