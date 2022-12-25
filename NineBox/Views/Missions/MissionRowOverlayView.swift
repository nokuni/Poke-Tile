//
//  MissionRowOverlayView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 12/03/2022.
//

import SwiftUI

struct MissionRowOverlayView: View {
    @Binding var selectedReward: Card?
    @Binding var mission: Mission
    @Binding var isShowingReward: Bool
    var size: CGSize
    
    var card: Card {
        return try! Card.getPokemon(name: mission.reward)
    }
    
    var body: some View {
        HStack {
            Text(mission.description)
                .foregroundColor(.white)
                .font(.system(size: size.width * 0.04, weight: .semibold, design: .rounded))
            
            Spacer()
            if !mission.isDone {
                CardView(card: card, size: size, amount: 6, isPossessing: nil)
            } else {
                if mission.reward.isEmpty {
                    Text("Completed")
                        .foregroundColor(.white)
                        .font(.system(size: size.width * 0.04, weight: .bold, design: .rounded))
                        .padding(10)
                        .background(Color.customTeal.cornerRadius(5))
                } else {
                    Button(action: {
                        selectedReward = card
                        mission.reward = ""
                        isShowingReward.toggle()
                    }) {
                        Text("Claim reward")
                            .foregroundColor(.white)
                            .font(.system(size: size.width * 0.04, weight: .bold, design: .rounded))
                            .padding(10)
                            .background(Color.customTeal.cornerRadius(5))
                    }
                }
            }
        }
            .padding(.horizontal)
    }
}
struct MissionRowOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        MissionRowOverlayView(selectedReward: .constant(nil), mission: .constant(Mission.all[0]), isShowingReward: .constant(false), size: CGSize.screen)
    }
}
