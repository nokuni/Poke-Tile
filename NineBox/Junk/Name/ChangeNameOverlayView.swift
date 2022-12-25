//
//  ChangeNameOverlayView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 27/02/2022.
//

import SwiftUI

struct ChangeNameOverlayView: View {
    @Binding var isShowingNameAlert: Bool
    @Binding var name: String
    @State var text = ""
    @State var focusState = FocusState()
    var size: CGSize
    var body: some View {
        VStack(spacing: 20) {
            Text("Give a name to your deck")
                .foregroundColor(.black)
                .font(.system(size: size.width * 0.05, weight: .regular, design: .rounded))
            ZStack {
                FocusableTextField<FocusState>(
                    fieldKind: .primaryText,
                    text: $text,
                    focusedField: $focusState.focusedField,
                    isFirstResponder: focusState.focusedField == .primaryText
                )
                .placeholder(when: text.isEmpty) {
                    Text("\(name)")
                        .foregroundColor(.white)
                }
                .padding(.leading)
                .accentColor(.white)
                .foregroundColor(.white)
                .disableAutocorrection(true)
            }
            .frame(width: size.width * 0.8, height: size.height * 0.05)
            .background(Color.steelBlue.cornerRadius(5))
            .padding()
            .onTapGesture { focusState.isInFocus = true }
            
            Text("Confirm deck name ?")
                .foregroundColor(.black)
                .font(.system(size: size.width * 0.05, weight: .regular, design: .rounded))
            HStack(spacing: 15) {
                Button(action: {
                    focusState.isInFocus = false
                    isShowingNameAlert.toggle()
                }) {
                    Text("No")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(5)
                        .frame(maxWidth: .infinity)
                        .background(Color.steelBlue.cornerRadius(5))
                }
                Button(action: {
                    focusState.isInFocus = false
                    isShowingNameAlert.toggle()
                    name = text.isEmpty ? "New Deck" : text
                }) {
                    Text("Yes")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .padding(5)
                        .frame(maxWidth: .infinity)
                        .background(Color.steelBlue.cornerRadius(5))
                }
            }
            .padding()
        }
    }
}

struct ChangeNameOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeNameOverlayView(isShowingNameAlert: .constant(false), name: .constant(""), size: CGSize.screen)
    }
}
