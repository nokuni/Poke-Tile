//
//  LabNavigationLink.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 14/03/2022.
//

import SwiftUI

struct LabNavigationLink<V: View>: View {
    var lab: LabModel
    var size: CGSize
    var view: V
    init(lab: LabModel, size: CGSize, @ViewBuilder view: @escaping () -> V) {
        self.lab = lab
        self.size = size
        self.view = view()
    }
    var body: some View {
        NavigationLink(destination: view) {
            LabRowView(lab: lab, size: size)
        }
        .disabled(!lab.isUnlocked)
    }
}

struct LabNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        LabNavigationLink(lab: LabModel.all[0], size: CGSize.screen, view: { })
    }
}
