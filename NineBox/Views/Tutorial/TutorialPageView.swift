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
                .font(.system(size: size.width * 0.06, weight: .regular, design: .rounded))
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
        TutorialPageView(page: TutorialPage.all[0], size: CGSize.screen, userVM: UserViewModel(), selectedPageIndex: .constant(0), isPresentingTutorial: .constant(false))
    }
}

struct ImagesGenreChoiceView: View {
    var images: [String]?
    var size: CGSize
    @Binding var selectedGenreIndex: Int
    var body: some View {
        if let images = images {
            HStack {
                ForEach(images.indices, id: \.self) { index in
                    VStack {
                        PointingArrowView(size: size)
                            .opacity(selectedGenreIndex == index ? 1 : 0)
                        Button(action: {
                            selectedGenreIndex = index
                        }) {
                            Image(images[index])
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(5)
                                .shadow(color: selectedGenreIndex == index ? .white : .clear, radius: 5)
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
    }
}

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

struct NameChoiceView: View {
    var page: TutorialPage
    var size: CGSize
    @Binding var text: String
    @Binding var selectedPageIndex: Int
    @ObservedObject var userVM: UserViewModel
    var body: some View {
        if let isChoosingName = page.isChoosingName {
            if isChoosingName {
                TextField("Name", text: $text)
                    .padding()
                    .background(Color.teal.cornerRadius(5))
                    .padding()
                    .disableAutocorrection(true)
                
                Button(action: {
                    userVM.user.profile.name = text
                    selectedPageIndex += 1
                }) {
                    Text("OK")
                        .font(.system(size: size.width * 0.07, weight: .bold, design: .rounded))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(text.isEmpty ? .gray : .teal)
                                .shadow(color: .white, radius: 0, x: 2, y: 2)
                        )
                }
                .disabled(text.isEmpty)
            }
        }
    }
}

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
