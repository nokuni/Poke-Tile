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
    @EnvironmentObject var adventureVM: AdventureViewModel
    var region: WorldRegion
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: .trainers, region: region)
                    TrainerListView(size: geo.size, region: region, trainers: region.trainers, isActive: $isActive)
                    Spacer()
                    BottomScreenButtonsView(dismiss: dismiss, size: geo.size, isActive: $isActive)
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
        /*.onAppear {
            adventureVM.showTrainers(from: adventure)
        }*/
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView(region: WorldRegion.regions[0], isActive: .constant(false))
    }
}
