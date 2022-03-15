//
//  AdventureView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct AdventureView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var adventureVM: AdventureViewModel
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: .adventure)
                    AdventureListView(size: geo.size, adventureVM: adventureVM)
                    Spacer()
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .spacedScreen
        }
    }
}

struct AdventureView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureView(adventureVM: AdventureViewModel())
    }
}

struct AdventureListView: View {
    var size: CGSize
    @ObservedObject var adventureVM: AdventureViewModel
    var body: some View {
        ScrollView {
            VStack {
                AdventureNavigationLink(adventure: adventureVM.adventures[0], size: size) {
                    JourneyView()
                }
                AdventureNavigationLink(adventure: adventureVM.adventures[1], size: size) {
                    LabView(adventureVM: adventureVM)
                }
            }
        }
    }
}
