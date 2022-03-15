//
//  TutorialPageView.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 14/03/22.
//

import SwiftUI

struct TutorialPageView: View {
    @State var text = ""
    @State var selectedGenreIndex = 0
    var page: TutorialPage
    var size: CGSize
    @ObservedObject var userVM: UserViewModel
    @Binding var selectedPageIndex: Int
    @Binding var isPresentingTutorial: Bool
    var body: some View {
        VStack(spacing: 25) {
            Text(page.title)
                .font(.system(size: size.width * 0.08, weight: .bold, design: .rounded))
            ImagesGenreChoiceView(images: page.images, size: size, selectedGenreIndex: $selectedGenreIndex)
            Text(page.description)
                .font(.system(size: size.width * 0.05, weight: .regular, design: .rounded))
            GenreChoiceView(page: page, selectedGenreIndex: $selectedGenreIndex, selectedPageIndex: $selectedPageIndex, userVM: userVM)
            NameChoiceView(page: page, size: size, text: $text, selectedPageIndex: $selectedPageIndex, userVM: userVM)
            QuitTutorialView(page: page, size: size, isPresentingTutorial: $isPresentingTutorial)
            
            Spacer()
        }
        .foregroundColor(.white)
        .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
        .multilineTextAlignment(.center)
        .padding()
    }
}

struct TutorialPageView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPageView(page: TutorialPage.example, size: CGSize.screen, userVM: UserViewModel(), selectedPageIndex: .constant(0), isPresentingTutorial: .constant(false))
    }
}
