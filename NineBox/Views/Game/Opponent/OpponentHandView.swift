//
//  OpponentHandView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 19/02/2022.
//

import SwiftUI

struct OpponentHandView: View {
    var size: CGSize
    @ObservedObject var gameVM: GameViewModel
    var body: some View {
        if let trainer = gameVM.game.trainer {
            Image(trainer.background)
                .resizable()
                .centerCropped(radius: 5, alignment: .center)
                .frame(width: size.width, height: size.height * 0.1)
                .overlay(
                    TrainerImageView(size: size, height: 0.1, image: trainer.image)
                )
                .overlay(
                    OpponentInformations(gameVM: gameVM, size: size)
                )
        }
    }
}

struct OpponentHandView_Previews: PreviewProvider {
    static var previews: some View {
        OpponentHandView(size: CGSize.screen, gameVM: GameViewModel())
    }
}

struct PlayerPoints: View {
    var size: CGSize
    var points: Int
    var isUser: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(isUser ? .blue : .red, lineWidth: 2)
                .frame(width: size.width * 0.15, height: size.width * 0.15)
                .background(Color.white.cornerRadius(5))
            Text("\(points)")
                .foregroundColor(isUser ? .blue : .red)
                .font(.system(size: size.width * 0.1, weight: .semibold, design: .rounded))
        }
    }
}

struct OpponentInformations: View {
    @ObservedObject var gameVM: GameViewModel
    var size: CGSize
    var body: some View {
        HStack(spacing: 25) {
            OpponentCardListView(size: size, gameVM: gameVM)
                .frame(width: size.width * 0.4, height: size.height * 0.1)
            PlayerPoints(size: size, points: gameVM.game.opponentPoints, isUser: false)
        }
        .frame(width: size.width * 0.9, alignment: .trailing)
        .padding(.trailing)
    }
}

struct UserInformations: View {
    @ObservedObject var gameVM: GameViewModel
    var size: CGSize
    var body: some View {
        ImageCroppedView(image: "volcano.background")
            .frame(width: size.width, height: size.height * 0.1)
            .overlay(
                TrainerImageView(size: size, height: 0.1, image: "blaine")
            )
            .overlay(
                PlayerPoints(size: size, points: gameVM.game.userPoints, isUser: true)
                    .frame(width: size.width * 0.9, alignment: .trailing)
                    .padding(.trailing)
            )
            .zIndex(-1)
    }
}

struct ImageCroppedView: View {
    var image: String
    var body: some View {
        Image(image)
            .resizable()
            .centerCropped(radius: 5, alignment: .center)
    }
}
