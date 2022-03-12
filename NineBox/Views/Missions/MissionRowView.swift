//
//  MissionRowView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 12/03/2022.
//

import SwiftUI

struct MissionRowView: View {
    @Binding var mission: Mission
    var size: CGSize
    @Binding var isShowingReward: Bool
    @Binding var selectedReward: Card?
    
    var card: Card {
        return try! Card.getPokemon(name: mission.reward)
    }
    var body: some View {
        Color.steelBlue
            .cornerRadius(5)
            .padding(5)
            .frame(width: size.width, height: size.height * 0.1)
            .overlay(
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
                                .background(Color.teal.cornerRadius(5))
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
                                    .background(Color.teal.cornerRadius(5))
                            }
                        }
                    }
                }
                    .padding(.horizontal)
                
            )
    }
}

struct MissionRowView_Previews: PreviewProvider {
    static var previews: some View {
        MissionRowView(mission: .constant(Mission.all[0]), size: CGSize.screen, isShowingReward: .constant(false), selectedReward: .constant(nil))
    }
}
