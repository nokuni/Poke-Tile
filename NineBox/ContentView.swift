//
//  TestView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 20/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State var isActive : Bool = false

    var body: some View {
        NavigationView {
            NavigationLink(
                destination: ContentView2(rootIsActive: self.$isActive),
                isActive: self.$isActive
            ) {
                Text("Hello, World!")
            }
            .isDetailLink(false)
            //.navigationBarTitle("Root")
        }
    }
}

struct ContentView2: View {
    @Binding var rootIsActive : Bool

    var body: some View {
        NavigationLink(destination: ContentView3(shouldPopToRootView: self.$rootIsActive)) {
            Text("Hello, World #2!")
        }
        .isDetailLink(false)
        //.navigationBarTitle("Two")
    }
}

struct ContentView3: View {
    @Binding var shouldPopToRootView : Bool

    var body: some View {
        VStack {
            Text("Hello, World #3!")
            Button (action: { self.shouldPopToRootView = false } ){
                Text("Pop to root")
            }
        }
        //.navigationBarTitle("Three")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
