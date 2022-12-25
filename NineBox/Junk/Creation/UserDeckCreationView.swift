//
//  UserDeckCreationView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 02/03/2022.


import SwiftUI

struct UserDeckCreationView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var gameVM: GameViewModel
    //@StateObject var deckVM = DeckViewModel()
    @State var cards = Card.placeholders
    @State var selectedIndex = 0
    @State var selectedCard: Card? = nil
    @State var placeholderName = "New Deck"
    @State var isShowingNameAlert = false
    //var size: CGSize
    
    var deck: Deck {
        let cardNames = cards.map { $0.name }
        return Deck(name: placeholderName, associatedType: .bug, pokemons: cardNames, background: "forest.background")
    }
    var isDeckFilled: Bool {
        cards.allSatisfy({ $0.category == .pokemon })
    }
    var isCostRight: Bool {
        return deck.cost <= 50
    }
    var canCreateDeck: Bool {
        isCostRight && isDeckFilled
    }
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.deckCreation.rawValue)
                    
                    ChangeDeckNameButtonView(isShowingNameAlert: $isShowingNameAlert, name: $placeholderName)
                    
                    UserDeckPlaceholderView(cards: $cards, selectedIndex: $selectedIndex)
                    
                    HStack {
                        Text("COST")
                            .foregroundColor(.black)
                        Text("\(deck.cost)")
                            .foregroundColor(isCostRight ? .mediumSeaGreen : .crimson)
                        Spacer()
                        Text(isCostRight ? "" : "The deck cost is too high")
                            .foregroundColor(.crimson)
                    }
                    .font(.system(size: CGSize.screen.height * 0.025, weight: .bold, design: .rounded))
                    
                    UserSetCardListView(size: geo.size, selectedIndex: $selectedIndex, selectedCard: $selectedCard, cards: $cards, gameVM: gameVM)
                        .frame(height: geo.size.height * 0.35)
                    
                    Button(action: {
                        gameVM.user.user.decks.insert(deck, at: 0)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        LongButtonView(text: "CREATE", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: !canCreateDeck ? .gray : .orangeApp, buttonStrokeColor: .steelBlue)
                    }
                    .disabled(!canCreateDeck)
                    
                    Spacer()
                    
                    BackButtonView(size: geo.size)
                }
            }
            .padding()
            
            if isShowingNameAlert {
                ChangeNameAlertModalView(isShowingNameAlert: $isShowingNameAlert, name: $placeholderName)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard)
    }
}

struct UserDeckCreationView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckCreationView()
    }
}
