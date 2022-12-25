//
//  NineBoxApp.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 16/02/2022.
//

import SwiftUI

@main
struct NineBoxApp: App {
    @StateObject var gameVM = GameViewModel.shared
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(gameVM)
                .statusBar(hidden: true)
                //.navigationBarHidden(true)
                //.navigationBarBackButtonHidden(true)
        }
    }
}
