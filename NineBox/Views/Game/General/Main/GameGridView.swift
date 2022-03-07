//
//  GameGridView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/02/2022.
//

import SwiftUI

struct GameGridView: View {
    private let columns = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 4)
    func overlay(_ index: Int) -> some View {
        GeometryReader { geo in
            Color.clear.cornerRadius(5)
                .onChange(of: geo.frame(in: .global)) { newValue in
                    gameVM.game.boardFrames[index] = geo.frame(in: .global)
                }
        }
    }
    var size: CGSize
    @ObservedObject var gameVM: GameViewModel
    @Binding var isRotating: [Bool]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            if !gameVM.game.board.isEmpty {
                ForEach(gameVM.game.board.indices) { index in
                    CardGestureView(isRotating: $isRotating[index], size: size, card: gameVM.game.board[index], index: index, cardDropped: gameVM.cardDropped)
                        //.shadow(color: gameVM.game.board[index].side == .user ? .blue : gameVM.game.board[index].side == .opponent ? .red : .clear, radius: 2)
                        .allowsHitTesting(false)
                        .overlay(overlay(index))
                }
            }
        }
        .background(
            Image("forest.background")
                .resizable()
                .centerCropped(radius: 5, alignment: .center)
        )
    }
}

struct GameGridView_Previews: PreviewProvider {
    static var previews: some View {
        GameGridView(size: CGSize.screen, gameVM: GameViewModel(), isRotating: .constant([Bool](repeating: false, count: 16)))
    }
}

//LazyVGrid(columns: columns, spacing: 0) {
//    if !gameVM.game.board.isEmpty {
//        ForEach(gameVM.game.board.indices) { index in
//            CardGestureView(isRotating: $isRotating[index], size: size, card: gameVM.game.board[index], index: index, cardDropped: gameVM.cardDropped)
//                .shadow(color: gameVM.game.board[index].side == .user ? .blue : gameVM.game.board[index].side == .opponent ? .red : .clear, radius: 2)
//                .allowsHitTesting(false)
//                .overlay(overlay(index))
//        }
//    }
//}
//.background(Color.blue.cornerRadius(5))
