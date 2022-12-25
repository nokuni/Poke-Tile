//
//  NameChoiceView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 15/03/2022.
//

import SwiftUI
import Combine

struct NameChoiceView: View {
    @EnvironmentObject var gameVM: GameViewModel
    private let textLimit = 15
    var page: TutorialPage
    var size: CGSize
    @State private var focusState = FocusState()
    @Binding var text: String
    @Binding var selectedPageIndex: Int
    var body: some View {
        if let isChoosingName = page.isChoosingName {
            if isChoosingName {
                FocusableTextField<FocusState>(
                    fieldKind: .primaryText,
                    text: $text,
                    focusedField: $focusState.focusedField,
                    isFirstResponder: focusState.focusedField == .primaryText
                )
                .foregroundColor(.steelBlue)
                .padding(10)
                .frame(width: size.width * 0.8, height: size.height * 0.05)
                .background(Color.white.cornerRadius(5))
                .disableAutocorrection(true)
                .onReceive(Just(text)) { _ in limitText(textLimit, text: &text) }
                
                Button(action: {
                    gameVM.user.user.profile.name = text
                    selectedPageIndex += 1
                }) {
                    Text("OK")
                        .font(.system(size: size.width * 0.07, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .strokeText(color: .steelBlue)
                        .padding(5)
                        .frame(width: size.width * 0.82)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(text.isEmpty ? .gray : .mediumBlueApp)
                                .strokeText(color: .steelBlue)
                        )
                }
                .disabled(text.isEmpty)
            }
        }
    }
}

struct NameChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        NameChoiceView(page: TutorialPage.example, size: CGSize.screen, text: .constant(""), selectedPageIndex: .constant(0))
    }
}
