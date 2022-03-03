//
//  StarterDecksModalView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct StarterDecksModalView: View {
    @State var selectedBooster: Booster? = nil
    @ObservedObject var gameVM: GameViewModel
    @Binding var isShowingStarterModal: Bool
    var body: some View {
        ZStack {
            Background
            GeometryReader { geo in
                VStack {
                    Title
                    StarterBoosters
                    ChooseBoosterButton
                }
            }
            .padding()
        }
    }
}

struct StarterDecksModalView_Previews: PreviewProvider {
    static var previews: some View {
        StarterDecksModalView(gameVM: GameViewModel(), isShowingStarterModal: .constant(false))
    }
}

extension StarterDecksModalView {
    var Background: some View {
        Color.black.opacity(0.7).ignoresSafeArea()
    }
    
    var Title: some View {
        Text("Choose your starting booster")
            .foregroundColor(.white)
            .font(.system(size: CGSize.screen.width * 0.1, weight: .bold, design: .rounded))
            .multilineTextAlignment(.center)
    }
    var StarterBoosters: some View {
        StarterBoosterListView(starters: Booster.starters, size: CGSize.screen, selectedBooster: $selectedBooster)
    }
    
    var ChooseBoosterButton: some View {
        Button(action: {
            if let selectedBooster = selectedBooster {
                gameVM.user.boosters.append(selectedBooster)
            }
            isShowingStarterModal.toggle()
        }) {
            LongButtonView(text: "I choose this one!", textColor: .white, textSize: 0.08, backgroundColor: selectedBooster == nil ? .gray : selectedBooster?.type.color ?? .gray, borderColor: .white)
                .shadow(color: .white, radius: 3)
                .padding(.vertical)
        }
        .disabled(selectedBooster == nil)
    }
}
