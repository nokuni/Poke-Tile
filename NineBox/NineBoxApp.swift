//
//  NineBoxApp.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/02/2022.
//

import SwiftUI

@main
struct NineBoxApp: App {
    @StateObject var gameVM = GameViewModel()
    @StateObject var userVM = UserViewModel()
    @StateObject var adventureVM = AdventureViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(gameVM)
                .environmentObject(userVM)
                .environmentObject(adventureVM)
        }
    }
}
