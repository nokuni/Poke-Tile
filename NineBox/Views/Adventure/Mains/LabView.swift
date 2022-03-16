//
//  LabView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct LabView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isActive: Bool
    @ObservedObject var adventureVM: AdventureViewModel
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: .lab)
                    LabListView(adventureVM: adventureVM, size: geo.size, isActive: $isActive)
                    Spacer()
                    BottomScreenButtonsView(dismiss: dismiss, size: geo.size, isActive: $isActive)
                }
            }
            .spacedScreen
        }
    }
}

struct LabView_Previews: PreviewProvider {
    static var previews: some View {
        LabView(isActive: .constant(false), adventureVM: AdventureViewModel())
    }
}
