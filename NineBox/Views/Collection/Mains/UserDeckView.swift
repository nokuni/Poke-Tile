//
//  UserDeckView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct UserDeckView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @State var filter: DeckFilters = .playable
    @State var isShowingAdvancedFilters = false
    @State var isShowingDeckCreation = false
    @State var decks = [Deck]()
    @State var selectedTypes = [CardType]()
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.decks.rawValue)
                        .padding(.horizontal)
                        .padding(.top)
                    UserDeckFilterView(selectedFilter: $filter, isShowingAdvancedFilters: $isShowingAdvancedFilters)
                        .padding(.horizontal)
                    UserDeckListView(decks: decks, size: geo.size, isPossessing: gameVM.user.isPossessing, isDeckPlayable: gameVM.user.isDeckPlayable)
                    
                    Spacer()
                    
                    HStack {
                        
                        BackButtonView(size: geo.size)
                        
                        Button(action: {
                            isShowingDeckCreation.toggle()
                        }) {
                            ActionButtonView(text: "CREATE DECK", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: .orangeApp, buttonStrokeColor: .steelBlue)
                        }
                        .padding(.leading)
                    }
                    .padding()
                }
            }
            //.padding()
            
            if isShowingAdvancedFilters {
                UserDeckAdvanceFilterView(size: CGSize.screen, isShowingAdvancedFilters: $isShowingAdvancedFilters, decks: $decks, selectedTypes: $selectedTypes)
            }
            
            if isShowingDeckCreation {
                UserDeckCreationView()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            decks = gameVM.user.user.decks
            print("DECKS ATTRIBUTED")
        }
//        .onChange(of: filter, perform: { newValue in
//            gameVM.user.user.decks = gameVM.user.filteredDecks(filter: newValue)
//        })
    }
}

struct UserDeckView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckView()
    }
}

struct UserDeckAdvanceFilterView: View {
    @EnvironmentObject var gameVM: GameViewModel
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 3)
    var size: CGSize
    @Binding var isShowingAdvancedFilters: Bool
    @Binding var decks: [Deck]
    @Binding var selectedTypes: [CardType]
    var types: [CardType] {
        return CardType.allCases.filter { $0 != .empty }
    }
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: size.height * 0.8)
                .padding()
            VStack {
                LazyVGrid(columns: grid, spacing: 20) {
                    ForEach(types, id: \.self) { type in
                        Button(action: {
                            if selectedTypes.contains(type) {
                                selectedTypes.remove(object: type)
                            } else {
                                selectedTypes.append(type)
                            }
                            
                            let selectedTypeNames = selectedTypes.map { $0.rawValue }
                            
                            decks = gameVM.user.user.decks
                            
                            decks = decks.filter { deck in
                                selectedTypeNames.contains { deck.types.contains($0) }
                            }
                            
                        }) {
                            HStack {
                                Image(type.rawValue)
                                    .resizable()
                                    .frame(width: size.width * 0.05, height: size.width * 0.05)
                                Text(type.rawValue.capitalized)
                                    .fontWeight(.bold)
                                    .font(.system(size: size.width * 0.03, weight: .bold, design: .rounded))
                                    .foregroundColor( selectedTypes.contains(type) ? .white : .steelBlue)
                            }
                            .padding(10)
                            .frame(width: size.width * 0.25, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(selectedTypes.contains(type) ? .steelBlue : .lightBlueApp)
                                    .cornerRadius(5)
                                    .strokeText(color: .steelBlue)
                            )
                        }
                    }
                }
                .padding()
                
                Button(action: {
                    selectedTypes.removeAll()
                    decks = gameVM.user.user.decks
                }) {
                    ActionButtonView(text: "RESET", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: .orangeApp, buttonStrokeColor: .steelBlue)
                        .frame(width: size.width * 0.86)
                }
                .padding()
                
                Button(action: {
                    isShowingAdvancedFilters.toggle()
                }) {
                    ActionButtonView(text: "CLOSE", textColor: .white, textSize: 0.025, textStrokeColor: .maroon, buttonColor: .crimson, buttonStrokeColor: .maroon)
                        .frame(width: size.width * 0.86)
                }
                .padding()
            }
        }
    }
}
