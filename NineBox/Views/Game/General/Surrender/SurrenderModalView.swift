//
//  SurrenderModalView.swift
//  NineBox
//
//  Created by Yann Christophe Maertens on 01/03/2022.
//

import SwiftUI

struct SurrenderModalView: View {
    @Binding var isShowingGameEnding: Bool
    @Binding var isShowingSurrenderModal: Bool
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                LazyVStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.steelBlue, lineWidth: 5)
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.4)
                        .background(Color.white.cornerRadius(5))
                        .overlay(
                            VStack {
                                Text("Do you really want to surrender this battle ?")
                                    .foregroundColor(.black)
                                    .font(.system(size: CGSize.screen.width * 0.06, weight: .regular, design: .rounded))
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical)
                                HStack(spacing: 20) {
                                    Button(action: {
                                        isShowingSurrenderModal.toggle()
                                    }) {
                                        LongButtonView(text: "No", textColor: .white, textSize: 0.05, backgroundColor: .steelBlue, borderColor: .black)
                                    }
                                    Button(action: {
                                        isShowingSurrenderModal.toggle()
                                        isShowingGameEnding.toggle()
                                    }) {
                                        LongButtonView(text: "Yes", textColor: .white, textSize: 0.05, backgroundColor: .crimson, borderColor: .black)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        )
                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

struct SurrenderModalView_Previews: PreviewProvider {
    static var previews: some View {
        SurrenderModalView(isShowingGameEnding: .constant(false), isShowingSurrenderModal: .constant(false))
    }
}
