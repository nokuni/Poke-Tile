//
//  UserDeckSearchView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 04/03/2022.
//

import SwiftUI

struct UserDeckFilterView: View {
    @Binding var selectedFilter: DeckFilters
    @Binding var isShowingAdvancedFilters: Bool
    var body: some View {
        HStack {
//            ForEach(DeckFilters.allCases, id: \.self) { filter in
//                UserDeckFilterButtonView(filter: filter, selectedFilter: $selectedFilter)
//            }
            Button(action: {
                isShowingAdvancedFilters.toggle()
            }) {
                ActionButtonView(text: "FILTERS", textColor: .white, textSize: 0.025, textStrokeColor: .brownApp, buttonColor: .orangeApp, buttonStrokeColor: .steelBlue)
            }
        }
    }
}

struct UserDeckFilterView_Previews: PreviewProvider {
    static var previews: some View {
        UserDeckFilterView(selectedFilter: .constant(.all), isShowingAdvancedFilters: .constant(false))
    }
}

