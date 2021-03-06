//
//  HomeView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 19/02/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var missionVM: MissionViewModel
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var adventureVM: AdventureViewModel
    @State var isShowingModalTheme = false
    @AppStorage("tutorial") var isInTutorial = true
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        HStack(spacing: 0) {
                            HomeNavigationLink(size: geo.size, item: homeVM.homeItems[0], theme: userVM.user.profile.theme, isActive: $userVM.isInUserDecks) {
                                UserDeckView(userVM: userVM)
                            }
                            HomeNavigationLink(size: geo.size, item: homeVM.homeItems[1], theme: userVM.user.profile.theme, isActive: $userVM.isInUserCardCollection) {
                                UserCardsView(userVM: userVM)
                            }
                            HomeNavigationLink(size: geo.size, item: homeVM.homeItems[2], theme: userVM.user.profile.theme, isActive: $adventureVM.isInAdventure) {
                                AdventureView(isActive: $adventureVM.isInAdventure, adventureVM: adventureVM)
                                }
                            
                            HomeNavigationLink(size: geo.size, item: homeVM.homeItems[3], theme: userVM.user.profile.theme, isActive: $missionVM.isInMissions) {
                                MissionsView(missionVM: missionVM)
                            }
                        }
                    }
                }
                
                if homeVM.isShowingStartingTutorial {
                    TutorialView(trainer: try! Trainer.getTutorialTrainer("Beginning Prof.Oak"), isPresentingTutorial: $homeVM.isShowingStartingTutorial, userVM: userVM, adventureVM: adventureVM, homeVM: homeVM)
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

struct ThemeButtonView: View {
    @Binding var isShowingModalTheme: Bool
    var size: CGSize
    var body: some View {
        Button(action: {
            isShowingModalTheme.toggle()
        }) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.steelBlue, lineWidth: 3)
                .frame(width: size.width * 0.1, height: size.width * 0.1, alignment: .trailing)
                .background(Color.white.cornerRadius(5))
                .overlay(
                    Image("025")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.steelBlue)
                        .scaledToFit()
                        .scaleEffect(0.8)
                )
                .padding(.trailing)
                .frame(width: size.width, alignment: .trailing)
        }
    }
}

struct ThemeModalView: View {
    @Binding var isShowingModalTheme: Bool
    @Binding var theme: Theme
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    HStack {
                        Button(action: {
                            isShowingModalTheme.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.steelBlue, lineWidth: 3)
                                .frame(width: geo.size.width * 0.1, height: geo.size.width * 0.1)
                                .background(Color.white.cornerRadius(5))
                                .overlay(
                                    Image(systemName: "multiply")
                                        .font(.system(size: geo.size.width * 0.1, weight: .regular, design: .rounded))
                                )
                                .padding(.trailing)
                                .frame(width: geo.size.width, alignment: .trailing)
                        }
                    }
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(Theme.all) { theme in
                                Button(action: {
                                    self.theme = theme
                                }) {
                                    Image(theme.image)
                                        .resizable()
                                        .centerCropped(radius: 0, alignment: .center)
                                        .frame(width: geo.size.width, height: geo.size.height * 0.25)
                                }
                            }
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height * 0.4)
                    Text("Choose a wallpaper")
                        .foregroundColor(.white)
                        .font(.system(size: geo.size.width * 0.08, weight: .bold, design: .rounded))
                }
            }
        }
    }
}
