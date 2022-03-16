//
//  TrainerListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TrainerListView: View {
    @State private var selection: UUID?
    var size: CGSize
    var region: WorldRegion
    var trainers: [Trainer]
    @Binding var isActive: Bool
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(trainers) { trainer in
                    NavigationLink(
                        destination: PreBattleView(region: region, trainer: trainer, isActive: $isActive),
                        tag: trainer.id,
                        selection: $selection,
                        label: {
                            TrainerRowView(size: size, region: region, background: trainer.background, colorBorder: region.debuff.borderColor, image: trainer.image, isUnlocked: trainer.isUnlocked, hasBeenCleared: trainer.hasBeenCleared)
                        })
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
        TrainerListView(size: CGSize.screen, region: WorldRegion.regions[0], trainers: [], isActive: .constant(false))
    }
}

struct TrainerRowOverlayView: View {
    var isUnlocked: Bool
    var size: CGSize
    var body: some View {
        ZStack {
            if !isUnlocked {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.black.opacity(0.5))
                Image(systemName: "lock.fill")
                    .foregroundColor(.white)
                    .font(.system(size: size.width * 0.1, weight: .bold, design: .rounded))
            }
        }
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
