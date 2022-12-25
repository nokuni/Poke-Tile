//
//  TestView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @StateObject var gameVM = GameViewModel()
    @State var offset: CGSize = .zero
    var type: CardType
    @State var opacity: Double = 1
    @State var scale: Double = 1
    var body: some View {
        GeometryReader { geo in
            Image(type.rawValue)
                .resizable()
                .frame(width: CGSize.screen.height * 0.1, height: CGSize.screen.height * 0.1)
                .opacity(opacity)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.linear.repeatCount(2, autoreverses: false)) {
                        scale = 5
                        opacity = 0
                    }
                }
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
        .scaleEffect(0.3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(type: .fire)
    }
}

extension CGPoint {
    static var center: CGPoint {
        CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    }
}

//3 starters to begin with
//maximum 3 types in a deck
//limited cost to 50
//
//rarity: Common, Uncommon, Rare, Epic, Legendary
//
//COSTS:
//Legendary: 15-21
//Epic: 12-15
//Rare: 8-12
//Uncommon: 5-8
//Common: 1-5
//
// 4 Common
// 2 Uncommon
// 1 Rare
// 1 Epic
//
// 5 Fire
// 2 Normal
// 1 Bug
//
//Charmander5(common) - Ponyta6(uncommon) - Miaouss3(common) - Charmeleon11(rare) - Magmar14(epic) - Machoc3(common) - Caninos6(uncommon) - Rattata2(Common) = 50
//Fire/Normal/Fighting
//
//Squirtle5(common) - Stari4(common) -  Eevee4(common) - Wartortle11(rare) - Lapras12(epic) - Pikachu2(common) - Otaria6(uncommon) - Psyduck6(uncommon)
//Water/Normal/Electric
//
//Bulbasaur5(common) - Exeggcute7(uncommon) -  Miaouss3(common) - Ivysaur11(rare) - Tangela12(epic) - Abra2(common) - Oddish2(common) - Lickitung8(rare)
// Grass/Normal/Psychic
//
//
//15 - 11 - 8 - 5 - 1 = 40
//21 - 15 - 11 - 8 - 5 = 60
