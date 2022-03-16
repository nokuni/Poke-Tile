//
//  TrainingView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var adventureVM: AdventureViewModel
    @Binding var isActive: Bool
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    NavigationTitleView(size: geo.size, navigationTitle: .training)
                    TrainingTrainersListView(trainers: adventureVM.tutorialTrainers, size: geo.size, isActive: $isActive)
                    Spacer()
                    BottomScreenButtonsView(dismiss: dismiss, size: geo.size, isActive: $isActive)
                }
            }
            .spacedScreen
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView(adventureVM: AdventureViewModel(), isActive: .constant(false))
    }
}
