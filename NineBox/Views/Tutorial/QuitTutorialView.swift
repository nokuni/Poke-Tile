//
//  QuitTutorialView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI

struct QuitTutorialView: View {
    var page: TutorialPage
    var size: CGSize
    @Binding var isPresentingTutorial: Bool
    var body: some View {
        if page.isQuitting != nil {
            Button(action: {
                isPresentingTutorial.toggle()
            }) {
                Text("Follow Prof.OAK")
                    .font(.system(size: size.width * 0.07, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.teal)
                            .shadow(color: .white, radius: 0, x: 2, y: 2)
                    )
            }
        }
    }
}

struct QuitTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        QuitTutorialView(page: TutorialPage.example, size: CGSize.screen, isPresentingTutorial: .constant(false))
    }
}
