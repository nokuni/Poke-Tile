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
    var trainer: Trainer
    var page: TutorialPage
    var size: CGSize
    @ObservedObject var userVM: UserViewModel
    @ObservedObject var adventureVM: AdventureViewModel
    @ObservedObject var homeVM: HomeViewModel
    @Binding var selectedPageIndex: Int
    @Binding var isPresentingTutorial: Bool
    var body: some View {
        VStack(spacing: 25) {
            Text(page.title)
                .font(.system(size: size.width * 0.08, weight: .bold, design: .rounded))
            ImagesGenreChoiceView(images: page.images, size: size, selectedGenreIndex: $selectedGenreIndex)
            Text(page.description)
                .font(.system(size: size.width * 0.045, weight: .regular, design: .rounded))
            GenreChoiceView(page: page, size: size, selectedGenreIndex: $selectedGenreIndex, selectedPageIndex: $selectedPageIndex, userVM: userVM)
            NameChoiceView(page: page, size: size, text: $text, selectedPageIndex: $selectedPageIndex, userVM: userVM)
            QuitTutorialView(page: page, size: size, isPresentingTutorial: $isPresentingTutorial, adventureVM: adventureVM, homeVM: homeVM)
            
            if let pages = trainer.pages {
                if selectedPageIndex == (Trainer.getPages(pages).count - 1) {
                    if Trainer.getPages(pages)[selectedPageIndex].title != "Important Message" {
                        Button(action: {
                            selectedPageIndex = 0
                        }) {
                            Text("Excuse me, can you repeat please?")
                                .foregroundColor(.white)
                                .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
                                .padding(5)
                                .frame(width: size.width * 0.82)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(.crimson)
                                        .shadow(color: .white, radius: 0, x: 2, y: 2)
                                )
                        }
                    }
                }
            }
            
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
        TutorialPageView(trainer: Trainer.worldTrainers[0],page: TutorialPage.example, size: CGSize.screen, userVM: UserViewModel(), adventureVM: AdventureViewModel(), homeVM: HomeViewModel(), selectedPageIndex: .constant(0), isPresentingTutorial: .constant(false))
    }
}
