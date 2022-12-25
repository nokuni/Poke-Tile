//
//  MissionsView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 12/03/2022.
//

import SwiftUI

struct MissionsView: View {
    @State var selectedReward: Card? = nil
    @State var isShowingReward = false
    var body: some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
            
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.missions.rawValue)
                    MissionListView(size: geo.size, selectedReward: $selectedReward, isShowingReward: $isShowingReward)
                    BackButtonView(size: geo.size)
                }
            }
            .spacedScreen
            
            if isShowingReward {
                if let selectedReward = selectedReward {
                    MissionRewardAnimationView(card: selectedReward, size: CGSize.screen, isShowingRewardView: $isShowingReward)
                }
            }
        }
    }
}

struct MissionsView_Previews: PreviewProvider {
    static var previews: some View {
        MissionsView()
    }
}
