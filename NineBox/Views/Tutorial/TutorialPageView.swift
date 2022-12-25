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
    @Binding var selectedPageIndex: Int
    @Binding var isPresentingTutorial: Bool
    var body: some View {
        VStack(spacing: 25) {
            Text(page.title)
                .font(.system(size: size.height * 0.04, weight: .black, design: .rounded))
                .foregroundColor(.white)
            ImagesGenreChoiceView(images: page.images, size: size, selectedGenreIndex: $selectedGenreIndex)
            Text(page.description)
                .font(.system(size: size.height * 0.025, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            GenreChoiceView(page: page, size: size, selectedGenreIndex: $selectedGenreIndex, selectedPageIndex: $selectedPageIndex)
            NameChoiceView(page: page, size: size, text: $text, selectedPageIndex: $selectedPageIndex)
            QuitTutorialView(page: page, size: size, isPresentingTutorial: $isPresentingTutorial)
            
            if let pages = trainer.pages {
                if selectedPageIndex == (Trainer.getPages(pages).count - 1) {
                    if Trainer.getPages(pages)[selectedPageIndex].title != "Important Message" {
                        Button(action: {
                            selectedPageIndex = 0
                        }) {
                            Text("Excuse me, can you repeat please?")
                                .font(.system(size: size.width * 0.05, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .strokeText(color: .maroon)
                                .padding(5)
                                .frame(width: size.width * 0.82)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(.crimson)
                                        .strokeText(color: .maroon)
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
        TutorialPageView(trainer: Trainer.worldTrainers[0],page: TutorialPage.example, size: CGSize.screen, selectedPageIndex: .constant(0), isPresentingTutorial: .constant(false))
    }
}
