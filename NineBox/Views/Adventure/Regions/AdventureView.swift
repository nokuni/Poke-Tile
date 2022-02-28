//
//  AdventureView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct AdventureView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            GeometryReader { geo in
                LazyVStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: .adventure)
                    AdventureListView(size: geo.size)
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
