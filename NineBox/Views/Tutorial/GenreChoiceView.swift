//
//  GenreChoiceView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI

struct GenreChoiceView: View {
    var page: TutorialPage
    var size: CGSize
    @Binding var selectedGenreIndex: Int
    @Binding var selectedPageIndex: Int
    @ObservedObject var userVM: UserViewModel
    var body: some View {
        if let isChoosingGenre = page.isChoosingGenre {
            if isChoosingGenre {
                Button(action: {
                    userVM.user.profile.image = page.images?[selectedGenreIndex] ?? "boy"
                    if page.images?[selectedGenreIndex] == "boy" {
                        userVM.user.profile.genre = .boy
                    } else if page.images?[selectedGenreIndex] == "girl" {
                        userVM.user.profile.genre = .girl
                    }
                    selectedPageIndex += 1
                }) {
                    Text(page.images?[selectedGenreIndex] == "boy" ? "I am a boy!" : "I am a girl!")
                        .font(.system(size: size.width * 0.07, weight: .bold, design: .rounded))
                        .padding(5)
                        .frame(width: size.width * 0.82)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(page.images?[selectedGenreIndex] == "boy" ? .dodgerBlue : .paleVioletRed)
                                .shadow(color: .white, radius: 0, x: 2, y: 2)
                        )
                }
            }
        }
    }
}

struct GenreChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        GenreChoiceView(page: TutorialPage.example, size: CGSize.screen, selectedGenreIndex: .constant(0), selectedPageIndex: .constant(0), userVM: UserViewModel())
    }
}
