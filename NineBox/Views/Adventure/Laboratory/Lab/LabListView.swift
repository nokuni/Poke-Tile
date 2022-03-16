//
//  LabListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct LabListView: View {
    @ObservedObject var adventureVM: AdventureViewModel
    var size: CGSize
    @Binding var isActive: Bool
    var body: some View {
        ScrollView {
            VStack {
                LabNavigationLink(lab: adventureVM.lab[0], size: size) {
                    TrainingView(adventureVM: adventureVM, isActive: $isActive)
                }
                LabNavigationLink(lab: adventureVM.lab[1], size: size) {
                    PuzzleView(isActive: $isActive)
                }
            }
        }
    }
}

struct LabListView_Previews: PreviewProvider {
    static var previews: some View {
        LabListView(adventureVM: AdventureViewModel(), size: CGSize.screen, isActive: .constant(false))
    }
}
