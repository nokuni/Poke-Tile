//
//  AdventureListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct AdventureListView: View {
    var adventures: [Adventure]
    var size: CGSize
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(adventures) { adventure in
                    NavigationLink(destination: TrainerView(adventure: adventure)) {
                        AdventureRowView(size: size, adventure: adventure)
                    }
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.powderBlue, .white, .powderBlue]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(5)
                .opacity(0.5)
        )
    }
}

struct AdventureListView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureListView(adventures: [], size: CGSize.screen)
    }
}
