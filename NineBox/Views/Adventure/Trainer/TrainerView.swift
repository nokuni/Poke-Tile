//
//  TrainerView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct TrainerView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var gameVM: GameViewModel
    var adventure: Adventure
    var body: some View {
        GeometryReader { geo in
            LazyVStack(alignment: .leading) {
                NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel(image: adventure.icon, title: adventure.title, color: adventure.debuff.borderColor))
                TrainerListView(size: geo.size, adventure: adventure)
                BackButtonView(size: geo.size, dismiss: dismiss)
            }
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView(adventure: Adventure.adventures[0])
    }
}
