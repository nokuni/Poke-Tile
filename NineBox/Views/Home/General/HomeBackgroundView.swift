//
//  HomeBackgroundView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 28/02/2022.
//

import SwiftUI

struct HomeBackgroundView: View {
    var theme: Theme
    var body: some View {
        ZStack {
            theme.color
                .ignoresSafeArea()
            Image(theme.image)
                .resizable()
                .scaledToFit()
        }
    }
}

struct HomeBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBackgroundView(theme: Theme.poliwag)
    }
}
