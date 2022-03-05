//
//  BoosterRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct BoosterRowView: View {
    var booster: Booster
    @ObservedObject var gameVM: GameViewModel
    var size: CGSize
    var boosterAmount: Int {
        gameVM.user.boosters.filter { $0.name == booster.name }.count
    }
    @Binding var selectedBooster: Booster?
    var body: some View {
        HStack {
            CardBoosterView(booster: booster, size: size)
                .frame(height: size.height * 0.2)
            Button(action: {
                selectedBooster = booster
                if let index = gameVM.user.boosters.firstIndex(of: booster) {
                    gameVM.user.boosters.remove(at: index)
                }
                gameVM.user.cards.append(contentsOf: booster.cards)
            }) {
                VStack {
                    Text("Open")
                        .font(.system(size: size.width * 0.06, weight: .bold, design: .rounded))
                    HStack {
                        Text("x")
                        Text("\(boosterAmount)")
                            .fontWeight(.black)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .frame(height: size.height * 0.2)
                .background(Color.crimson.cornerRadius(5))
            }
        }
    }
}

struct BoosterRowView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterRowView(booster: Booster.all[0], gameVM: GameViewModel(), size: CGSize.screen, selectedBooster: .constant(nil))
    }
}
