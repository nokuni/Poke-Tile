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
    @FocusState var isFocused: Bool
    var size: CGSize
    var body: some View {
        VStack(spacing: 20) {
            Text("Give a name to your deck")
                .font(.system(size: 20, weight: .regular, design: .rounded))
            ZStack {
                TextField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text("\(name)")
                            .foregroundColor(.white)
                    }
                    .padding(.leading)
                    .accentColor(.white)
                    .foregroundColor(.white)
                    .disableAutocorrection(true)
                    .focused($isFocused)
            }
            .frame(width: size.width * 0.8, height: size.height * 0.05)
            .background(Color.steelBlue.cornerRadius(5))
            .padding()
            .onTapGesture { isFocused = true }
            
            Text("Confirm deck name ?")
                .font(.system(size: 20, weight: .regular, design: .rounded))
            HStack(spacing: 15) {
                Button(action: {
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
