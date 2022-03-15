//
//  MissionListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 12/03/2022.
//

import SwiftUI

struct MissionListView: View {
    @ObservedObject var missionVM: MissionViewModel
    var size: CGSize
    @Binding var selectedReward: Card?
    @Binding var isShowingReward: Bool
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(missionVM.missions.indices, id: \.self) { index in
                    MissionRowView(mission: $missionVM.missions[index], isShowingReward: $isShowingReward, selectedReward: $selectedReward, size: size)
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.powderBlue, .white, .powderBlue]), startPoint: .top, endPoint: .bottom)
                .cornerRadius(5)
                .opacity(0.5)
        )
    }
}

struct MissionListView_Previews: PreviewProvider {
    static var previews: some View {
        MissionListView(missionVM: MissionViewModel(), size: CGSize.screen, selectedReward: .constant(Card.empty), isShowingReward: .constant(false))
    }
}
