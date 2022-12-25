//
//  TrainerListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TrainerListView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @State private var selection: UUID?
    var size: CGSize
    var region: WorldRegion
    var trainers: [Trainer]
    @Binding var isActive: Bool
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(trainers) { trainer in
                    Button(action: {
                        withAnimation {
                            if trainer.isUnlocked {
                                gameVM.adventure.selectedTrainer = trainer
                                gameVM.adventure.toggleWorldTrainerState(on: .inPreBattle)
                                gameVM.game = Game()
                            }
                        }
                    }) {
                        TrainerRowView(size: size, region: region, background: trainer.background, colorBorder: region.debuff.borderColor, image: trainer.image, isUnlocked: trainer.isUnlocked, hasBeenCleared: trainer.hasBeenCleared)
                    }
                }
            }
        }
        .onChange(of: gameVM.adventure.worldTrainerState, perform: { newValue in
            gameVM.adventure.worldTrainerState = newValue
        })
        .background(
            LinearGradient(gradient: Gradient(colors: [.powderBlue, .white, .powderBlue]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(5)
                .opacity(0.5)
        )
    }
}

struct TrainerListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerListView(size: CGSize.screen, region: WorldRegion.regions[0], trainers: [], isActive: .constant(false))
    }
}

//ForEach(trainers) { trainer in
//    Button(action: {
//        selectedTrainer = trainer
//        isActive = true
//    }) {
//        TrainerRowView(size: size, region: region, background: trainer.background, colorBorder: region.debuff.borderColor, image: trainer.image, isUnlocked: trainer.isUnlocked, hasBeenCleared: trainer.hasBeenCleared)
//    }
//}
//.background(
//    ZStack {
//        if let selectedTrainer = selectedTrainer {
//            NavigationLink(
//                destination: PreBattleView(trainer: selectedTrainer, isActive: $isActive),
//                isActive: $isActive) { EmptyView() }
//        }
//    }
//)
