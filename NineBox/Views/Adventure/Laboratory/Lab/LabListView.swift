//
//  LabListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct LabListView: View {
    @EnvironmentObject var gameVM: GameViewModel
    var size: CGSize
    @Binding var isActive: Bool
    var body: some View {
        ScrollView {
            VStack {
                LabNavigationLink(lab: gameVM.adventure.lab[0], size: size) {
                    TrainingView(isActive: $isActive)
                }
                LabNavigationLink(lab: gameVM.adventure.lab[1], size: size) {
                    PuzzleView(isActive: $isActive)
                }
            }
        }
    }
}

struct LabListView_Previews: PreviewProvider {
    static var previews: some View {
        LabListView(size: CGSize.screen, isActive: .constant(false))
    }
}
