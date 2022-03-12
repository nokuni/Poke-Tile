//
//  TrainerListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TrainerListView: View {
    var size: CGSize
    var adventure: Adventure
    var trainers: [Trainer]
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(trainers) { trainer in
                    NavigationLink(destination: PreBattleView(adventure: adventure, trainer: trainer)) {
                        TrainerRowView(size: size, adventure: adventure, image: trainer.image, isUnlocked: trainer.isUnlocked, hasBeenCleared: trainer.hasBeenCleared)
                            .overlay(
                                ZStack {
                                    if !trainer.isUnlocked {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(.black.opacity(0.5))
                                        Image(systemName: "lock.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
                                    }
                                }
                            )
                    }
                    .disabled(!trainer.isUnlocked)
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

struct TrainerListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerListView(size: CGSize.screen, adventure: Adventure.adventures[0], trainers: [])
    }
}
