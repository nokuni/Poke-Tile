//
//  TestView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct TestView: View {
    @State var isAnimating = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ForEach(0..<10) { _ in
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.2)
                        .frame(width: geo.size.width, height: geo.size.height * 0.2, alignment: .trailing)
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
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
