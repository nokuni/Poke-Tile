//
//  LooseAnimationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct EndingAnimationView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isAnimating = false
    @State private var isShowingMenu = false
    @Binding var isPresented: Bool
    @Binding var isShowingStart: Bool
    var resetGame: (() -> Void)?
    var loadGame: (() -> Void)?
    var isGameWon: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isGameWon ? .blue : .steelBlue)
                .opacity(0.7)
                .ignoresSafeArea()
            VStack {
                if isAnimating {
                    ZStack {
                            Image(isGameWon ? "win" : "loose")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(isGameWon ? 0.7 : 1)
                    }
                    .transition(.move(edge: .top))
                }
                EndingMenuView(isGameWon: isGameWon, resetGame: resetGame, loadGame: loadGame, dismiss: dismiss, isShowingStart: $isShowingStart)
            }
        }
        .onAppear {
            withAnimation(.spring()) {
                isAnimating.toggle()
            }
        }
    }
}

struct EndingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        EndingAnimationView(isPresented: .constant(false), isShowingStart: .constant(false), isGameWon: true)
    }
}

struct EndingMenuView: View {
    var isGameWon: Bool
    var resetGame: (() -> Void)?
    var loadGame: (() -> Void)?
    var dismiss: DismissAction?
    @Binding var isShowingStart: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(Color.black, lineWidth: 3)
            .background(Color.white)
            .overlay(
                VStack {
                    Text(isGameWon ? "WIN" : "GAME OVER")
                        .foregroundColor(.black)
                        .font(.system(size: CGSize.screen.width * 0.1, weight: .bold, design: .rounded))
                    if !isGameWon {
                        Button(action: {
                            loadGame?()
                            isShowingStart.toggle()
                        }) {
                            LongButtonView(text: "Retry", textColor: .white, backgroundColor: .steelBlue, borderColor: .black)
                        }
                    }
                    
                    Button(action: {
                        resetGame?()
                        dismiss?()
                    }) {
                        LongButtonView(text: "Quit", textColor: .white, backgroundColor: .steelBlue, borderColor: .black)
                    }
                }
                    .padding(.horizontal)
            )
            .padding()
    }
}
