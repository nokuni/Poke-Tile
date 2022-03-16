//
//  UserDeckView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct UserDeckView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userVM: UserViewModel
    @State var filter: DeckFilters = .playable
    @State var isShowingAdvancedFilters = false
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: NavigationTitleModel.decks)
                    UserDeckFilterView(selectedFilter: $filter, isShowingAdvancedFilters: $isShowingAdvancedFilters)
                    UserDeckListView(decks: userVM.user.decks, size: geo.size, isPossessing: userVM.isPossessing, isDeckPlayable: userVM.isDeckPlayable)
                    Spacer()
                    BackButtonView(size: geo.size, dismiss: dismiss)
                }
            }
            .padding()
            
            if isShowingAdvancedFilters {
                UserDeckAdvanceFilterView(size: CGSize.screen, isShowingAdvancedFilters: $isShowingAdvancedFilters)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            userVM.user.decks = userVM.filteredDecks(filter: filter)
        }
        .onChange(of: filter, perform: { newValue in
            userVM.user.decks = userVM.filteredDecks(filter: newValue)
        })
    }
}

struct UserDeckView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckView(userVM: UserViewModel())
    }
}

struct UserDeckAdvanceFilterView: View {
    private let grid = [GridItem](repeating: .init(.flexible(), spacing: 0), count: 3)
    var size: CGSize
    @Binding var isShowingAdvancedFilters: Bool
    
    var types: [CardType] {
        return CardType.allCases.filter { $0 != .empty }
    }
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: size.height * 0.63)
                .padding()
            VStack {
                LazyVGrid(columns: grid, spacing: 20) {
                    ForEach(types, id: \.self) { type in
                        Button(action: {
                            
                        }) {
                            HStack {
                                Image(type.rawValue)
                                    .resizable()
                                    .frame(width: size.width * 0.05, height: size.width * 0.05)
                                Text(type.rawValue.capitalized)
                                    .foregroundColor(.steelBlue)
                                    .font(.system(size: size.width * 0.03, weight: .bold, design: .rounded))
                            }
                            .padding(10)
                            .frame(width: size.width * 0.25, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .shadow(color: .black, radius: 0, x: 3, y: 3)
                            )
                        }
                    }
                }
                .padding()
                Button(action: {
                    isShowingAdvancedFilters.toggle()
                }) {
                    ActionButtonView(text: "Close", textColor: .white, color: .steelBlue, shadowColor: .black, size: size)
                        .frame(width: size.width * 0.86)
                }
            }
        }
    }
}
