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
    var booster: Booster
    @Binding var isPresented: Bool
    @Binding var isShowingStart: Bool
    var resetGame: (() -> Void)?
    var loadGame: (() -> Void)?
    var isGameWon: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isGameWon ? .blue : .crimson)
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
                EndingMenuView(isGameWon: isGameWon, resetGame: resetGame, loadGame: loadGame, dismiss: dismiss, booster: booster, isShowingStart: $isShowingStart)
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
        EndingAnimationView(booster: Booster.all[0], isPresented: .constant(false), isShowingStart: .constant(false), isGameWon: true)
    }
}

struct EndingMenuView: View {
    var isGameWon: Bool
    var resetGame: (() -> Void)?
    var loadGame: (() -> Void)?
    var dismiss: DismissAction?
    var booster: Booster
    @Binding var isShowingStart: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(Color.black, lineWidth: 3)
            .background(Color.white)
            .overlay(
                VStack {
                    if isGameWon {
                        Text("You obtained a booster !")
                            .foregroundColor(.black)
                            .font(.system(size: CGSize.screen.width * 0.05, weight: .bold, design: .rounded))
                        CardBoosterView(booster: booster, size: CGSize.screen)
                            .frame(height: CGSize.screen.height * 0.1)
                    }
                    
                    Text(isGameWon ? "WIN" : "GAME OVER")
                        .foregroundColor(.black)
                        .font(.system(size: CGSize.screen.width * 0.1, weight: .bold, design: .rounded))
                    if !isGameWon {
                        Button(action: {
                            loadGame?()
                            isShowingStart.toggle()
                        }) {
                            LongButtonView(text: "Retry", textColor: .white, textSize: 0.05, backgroundColor: .crimson, borderColor: .black)
                        }
                    }
                    
                    // TEMPORARY (WIP)
                    if isGameWon {
                        Button(action: {
                            loadGame?()
                            isShowingStart.toggle()
                        }) {
                            LongButtonView(text: "Next (WIP)", textColor: .white, textSize: 0.05, backgroundColor: .gray, borderColor: .black)
                        }
                        .disabled(true)
                    }
                    
                    Button(action: {
                        resetGame?()
                        dismiss?()
                    }) {
                        LongButtonView(text: "Quit", textColor: .white, textSize: 0.05, backgroundColor: .steelBlue, borderColor: .black)
                    }
                }
                    .padding(.horizontal)
            )
            .padding()
    }
}
