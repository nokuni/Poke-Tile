//
//  AdventureListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct AdventureListView: View {
    var size: CGSize
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(Adventure.adventures) { adventure in
                    NavigationLink(destination: TrainerView(adventure: adventure)) {
                        AdventureRowView(size: size, adventure: adventure)
                    }
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.powderBlue, .white, .powderBlue]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(10)
                .opacity(0.5)
        )
    }
}

struct AdventureListView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureListView(size: CGSize.screen)
    }
}
