//
//  GameGridView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/02/2022.
//

import SwiftUI

struct GameGridView: View {
    private let columns = [GridItem](repeating: .init(UIDevice.isOnPad ? .fixed(UIScreen.main.bounds.width * 0.15) : .flexible(), spacing: 0), count: 4)
    func overlay(_ index: Int) -> some View {
        GeometryReader { geo in
            Color.clear.cornerRadius(5)
                .onAppear {
                    gameVM.game.boardFrames[index] = geo.frame(in: .global)
                }
                .onChange(of: geo.frame(in: .global)) { newValue in
                    gameVM.game.boardFrames[index] = geo.frame(in: .global)
                }
        }
    }
    var size: CGSize
    @EnvironmentObject var gameVM: GameViewModel
    @Binding var isRotating: [Bool]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            if !gameVM.game.board.isEmpty {
                ForEach(gameVM.game.board.indices, id: \.self) { index in
                    CardGestureView(isRotating: $isRotating[index], size: size, card: gameVM.game.board[index], index: index, amount: UIDevice.isOnPad ? 6.2 : 4, cardDropped: gameVM.cardGestureAction.cardDropped)
                        //.shadow(color: gameVM.game.board[index].side == .user ? .blue : gameVM.game.board[index].side == .opponent ? .red : .clear, radius: 2)
                        .allowsHitTesting(false)
                        .overlay(overlay(index))
                        .overlay(
                            ZStack {
                                if gameVM.game.board[index].name != "Empty" {
                                    ContentView(type: gameVM.game.board[index].type)
                                }
                            }
                        )
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
        GameGridView(size: CGSize.screen, isRotating: .constant([Bool](repeating: false, count: 16)))
    }
}
