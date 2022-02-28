//
//  TrainerListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TrainerListView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var size: CGSize
    var adventure: Adventure
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(adventure.trainers, id: \.self) { trainer in
                    NavigationLink(destination: PreBattleView(gameVM: gameVM, trainerName: trainer, adventure: adventure)) {
                        TrainerRowView(size: size, adventure: adventure, trainer: try! Trainer.get(trainer))
                    }
                }
            }
        }
    }
}

struct TrainerListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerListView(size: CGSize.screen, adventure: Adventure.adventures[0])
    }
}
