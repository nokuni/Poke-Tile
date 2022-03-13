//
//  MissionRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 12/03/2022.
//

import SwiftUI

struct MissionRowView: View {
    @Binding var mission: Mission
    @Binding var isShowingReward: Bool
    @Binding var selectedReward: Card?
    var size: CGSize
    var body: some View {
        Color.steelBlue
            .cornerRadius(5)
            .padding(5)
            .frame(width: size.width, height: size.height * 0.1)
            .overlay(
                MissionRowOverlayView(selectedReward: $selectedReward, mission: $mission, isShowingReward: $isShowingReward, size: size)
            )
    }
}

struct MissionRowView_Previews: PreviewProvider {
    static var previews: some View {
        MissionRowView(mission: .constant(Mission.all[0]), isShowingReward: .constant(false), selectedReward: .constant(nil), size: CGSize.screen)
    }
}
