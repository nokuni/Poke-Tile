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
    @StateObject var missionVM = MissionViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeView()
                    .environmentObject(gameVM)
                    .environmentObject(userVM)
                    .environmentObject(adventureVM)
                    .environmentObject(missionVM)
                    .statusBar(hidden: true)
            }
        }
    }
}
