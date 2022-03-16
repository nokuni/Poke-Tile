//
//  AdventureListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct RegionsListView: View {
    @State private var selection: UUID?
    var regions: [WorldRegion]
    var size: CGSize
    @Binding var isActive: Bool
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(regions) { region in
                    NavigationLink(
                        destination: TrainerView(region: region, isActive: $isActive),
                        tag: region.id,
                        selection: $selection,
                        label: {
                            RegionRowView(size: size, region: region)
                        })
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

struct RegionsListView_Previews: PreviewProvider {
    static var previews: some View {
        RegionsListView(regions: [], size: CGSize.screen, isActive: .constant(false))
    }
}
