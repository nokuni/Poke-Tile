//
//  NameChoiceView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI

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
                    .foregroundColor(.steelBlue)
                    .padding(10)
                    .background(Color.white.cornerRadius(5))
                    .disableAutocorrection(true)
                
                Button(action: {
                    userVM.user.profile.name = text
                    selectedPageIndex += 1
                }) {
                    Text("OK")
                        .font(.system(size: size.width * 0.07, weight: .bold, design: .rounded))
                        .padding(5)
                        .frame(width: size.width * 0.82)
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

struct NameChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        NameChoiceView(page: TutorialPage.example, size: CGSize.screen, text: .constant(""), selectedPageIndex: .constant(0), userVM: UserViewModel())
    }
}
