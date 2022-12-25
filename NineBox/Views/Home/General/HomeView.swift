//
//  HomeView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 19/02/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @State var isShowingModalTheme = false
    @AppStorage("tutorial") var isInTutorial = true
    var body: some View {
        NavigationView {
            ZStack {
                Image("homeBackground")
                    .centerCropped(radius: 5, alignment: .center)
                    .ignoresSafeArea()
                //Color.white.ignoresSafeArea()
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        HStack(spacing: 0) {
                            
                            HomeNavigationLink(size: geo.size, item: gameVM.home.homeItems[0], theme: gameVM.user.user.profile.theme, isActive: $gameVM.summons.isInSummons) {
                                SummonsView()
                            }
                            HomeNavigationLink(size: geo.size, item: gameVM.home.homeItems[1], theme: gameVM.user.user.profile.theme, isActive: $gameVM.user.isInUserDecks) {
                                UserDeckView()
                            }
                            HomeNavigationLink(size: geo.size, item: gameVM.home.homeItems[2], theme: gameVM.user.user.profile.theme, isActive: $gameVM.user.isInUserCardCollection) {
                                UserCardsView()
                            }
                            HomeNavigationLink(size: geo.size, item: gameVM.home.homeItems[3], theme: gameVM.user.user.profile.theme, isActive: $gameVM.adventure.isInAdventure) {
                                AdventureView(isActive: $gameVM.adventure.isInAdventure)
                                }
                            
                            HomeNavigationLink(size: geo.size, item: gameVM.home.homeItems[4], theme: gameVM.user.user.profile.theme, isActive: $gameVM.mission.isInMissions) {
                                MissionsView()
                            }
                        }
                    }
                }
                
                if gameVM.home.isShowingStartingTutorial {
                    TutorialView(trainer: try! Trainer.getTutorialTrainer("Beginning Prof.Oak"), isPresentingTutorial: $gameVM.home.isShowingStartingTutorial)
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(GameViewModel())
    }
}
