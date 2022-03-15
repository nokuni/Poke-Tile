//
//  GenreChoiceView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI

struct GenreChoiceView: View {
    var page: TutorialPage
    @Binding var selectedGenreIndex: Int
    @Binding var selectedPageIndex: Int
    @ObservedObject var userVM: UserViewModel
    var body: some View {
        if let isChoosingGenre = page.isChoosingGenre {
            if isChoosingGenre {
                Button(action: {
                    userVM.user.profile.image = page.images?[selectedGenreIndex] ?? "userboy"
                    selectedPageIndex += 1
                }) {
                    Text(page.images?[selectedGenreIndex] == "userboy" ? "I am a boy!" : "I am a girl!")
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(page.images?[selectedGenreIndex] == "userboy" ? .dodgerBlue : .paleVioletRed)
                                .shadow(color: .white, radius: 0, x: 2, y: 2)
                        )
                }
            }
        }
    }
}

struct GenreChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        GenreChoiceView(page: TutorialPage.example, selectedGenreIndex: .constant(0), selectedPageIndex: .constant(0), userVM: UserViewModel())
    }
}
