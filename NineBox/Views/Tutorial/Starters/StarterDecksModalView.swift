//
//  StarterDecksModalView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 03/03/2022.
//

import SwiftUI

struct StarterDecksModalView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @State var selectedDeck: Deck? = nil
    @Binding var isShowingStarterModal: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.7).ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    
                    Text("Choose your starting booster")
                        .foregroundColor(.white)
                        .font(.system(size: CGSize.screen.width * 0.1, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                    
                    StarterBoosterListView(starters: Deck.starters, size: CGSize.screen, selectedDeck: $selectedDeck)
                    
                    Button(action: {
                        if let selectedBooster = selectedDeck {
                            gameVM.user.addCardsToCollection(selectedBooster.cards)
                        }
                        isShowingStarterModal.toggle()
                    }) {
                        LongButtonView(text: "I CHOOSE THIS ONE !", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: selectedDeck == nil ? .gray : selectedDeck?.associatedType.color ?? .gray, buttonStrokeColor: .steelBlue)
                            .shadow(color: .white, radius: 3)
                            .padding(.vertical)
                    }
                    .disabled(selectedDeck == nil)
                }
            }
            .padding()
        }
    }
}

struct StarterDecksModalView_Previews: PreviewProvider {
    static var previews: some View {
        StarterDecksModalView(isShowingStarterModal: .constant(false))
    }
}
