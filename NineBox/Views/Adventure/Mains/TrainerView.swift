//
//  TrainerView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 24/02/2022.
//

import SwiftUI

struct TrainerView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var region: WorldRegion
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            switch gameVM.adventure.worldTrainerState {
            case .inSelection:
                GeometryReader { geo in
                    VStack(alignment: .leading) {
                        NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.trainers.rawValue, region: region)
                        TrainerListView(size: geo.size, region: region, trainers: region.trainers, isActive: $isActive)
                        Spacer()
                        BottomScreenButtonsView(size: geo.size, isActive: $isActive)
                    }
                }
                .padding()
            case .inPreBattle:
                if let selectedTrainer = gameVM.adventure.selectedTrainer {
                    PreBattleView(region: region, trainer: selectedTrainer)
                }
            case .inBattle:
                GameView()
            }
        }
        .navigationBarHidden(true)
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
