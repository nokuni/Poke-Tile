//
//  AdventureView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct AdventureView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var adventureVM: AdventureViewModel
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: .adventure)
                    AdventureListView(adventures: adventureVM.adventures, size: geo.size)
                    Spacer()
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct AdventureView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureView()
    }
}
