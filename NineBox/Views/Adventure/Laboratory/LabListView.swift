//
//  LabListView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct LabListView: View {
    var size: CGSize
    var body: some View {
        ScrollView {
            VStack {
                LabNavigationLink(text: "Training", image: "lab", size: size) {
                    TrainingView()
                }
                LabNavigationLink(text: "Puzzles", image: "lab", size: size) {
                    PuzzleView()
                }
            }
        }
    }
}

struct LabListView_Previews: PreviewProvider {
    static var previews: some View {
        LabListView(size: CGSize.screen)
    }
}
