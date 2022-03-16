//
//  AdventureView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct AdventureView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isActive: Bool
    @ObservedObject var adventureVM: AdventureViewModel
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: .adventure)
                    AdventureListView(size: geo.size, isActive: $isActive, adventureVM: adventureVM)
                    Spacer()
                    BottomScreenButtonsView(dismiss: dismiss, size: geo.size, isActive: $isActive)
                }
            }
            .spacedScreen
        }
    }
}

struct AdventureView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureView(isActive: .constant(false) ,adventureVM: AdventureViewModel())
    }
}

struct AdventureListView: View {
    var size: CGSize
    @Binding var isActive: Bool
    @ObservedObject var adventureVM: AdventureViewModel
    var body: some View {
        ScrollView {
            VStack {
                AdventureNavigationLink(adventure: adventureVM.adventures[0], size: size) {
                    JourneyView(isActive: $isActive)
                }
                AdventureNavigationLink(adventure: adventureVM.adventures[1], size: size) {
                    LabView(isActive: $isActive, adventureVM: adventureVM)
                }
            }
        }
    }
}
