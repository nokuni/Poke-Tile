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
    
    var trainers: [Trainer] {
        gameVM.unlockedTrainers(from: adventure)
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(trainers.indices) { index in
                    NavigationLink(destination: PreBattleView(gameVM: gameVM, adventure: adventure, trainer: trainers[index])) {
                        TrainerRowView(size: size, adventure: adventure, trainer: trainers[index])
                            .overlay(
                                ZStack {
                                    if !trainers[index].isUnlocked {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(.black.opacity(0.5))
                                        Image(systemName: "lock.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
                                    }
                                }
                            )
                    }
                    .disabled(!trainers[index].isUnlocked)
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
