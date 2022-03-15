//
//  AdventureView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct AdventureView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.world)
                    AdventureListView(size: geo.size)
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
        AdventureView()
    }
}

struct AdventureListView: View {
    var size: CGSize
    var body: some View {
        ScrollView {
            VStack {
                AdventureNavigationLink(text: "World", image: "world.background", colorBorder: .mediumSeaGreen, size: size) {
                    JourneyView()
                }
                AdventureNavigationLink(text: "The Lab", image: "lab", colorBorder: .flyingBorder, size: size) {
                    LabView()
                }
            }
        }
    }
}

struct SpacedScreenModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    var spacedScreen: some View {
        modifier(SpacedScreenModifier())
    }
}
