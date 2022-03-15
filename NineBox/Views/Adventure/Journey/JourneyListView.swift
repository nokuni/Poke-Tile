//
//  AdventureListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct JourneyListView: View {
    var adventures: [Adventure]
    var size: CGSize
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(adventures) { adventure in
                    NavigationLink(destination: TrainerView(adventure: adventure)) {
                        JourneyRowView(size: size, adventure: adventure)
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

struct JourneyListView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyListView(adventures: [], size: CGSize.screen)
    }
}
