//
//  FocusableTextfield.swift
//  NineBox
//
//  Created by Maertens Yann-Christophe on 25/12/22.
//

import SwiftUI
import UIKit

protocol FocusFieldDelegate {
    associatedtype FocusFieldType: RawRepresentable where FocusFieldType.RawValue: StringProtocol
    var isInFocus: Bool { get set }
    var focusedField: FocusFieldType? { get set }
}

final class FocusState: ObservableObject, FocusFieldDelegate {
    typealias FocusFieldType = Field
    
    enum Field: String { case primaryText }
    
    @Published var isInFocus: Bool = false
    @Published var focusedField: FocusFieldType? = .primaryText
}

struct FocusableTextField<C: ObservableObject & FocusFieldDelegate>: UIViewRepresentable {
    
    func makeCoordinator() -> FocusableTextField.Coordinator {
        return Coordinator(fieldKind: fieldKind, text: $text, focusedField: $focusedField)
    }
    
    let fieldKind: C.FocusFieldType
    @Binding var text: String
    @Binding var focusedField: C.FocusFieldType?
    
    var isFirstResponder: Bool = false // false by default
    
    func makeUIView(context: UIViewRepresentableContext<FocusableTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<FocusableTextField>) {
        uiView.text = text
        
        // Manage focus state using coordinator
        if isFirstResponder && context.coordinator.didBecomeFirstResponder != true {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
            context.coordinator.didResignFirstResponder = false
        } else if !isFirstResponder && context.coordinator.didResignFirstResponder != true {
            uiView.resignFirstResponder()
            context.coordinator.didResignFirstResponder = true
            context.coordinator.didBecomeFirstResponder = false
        }
    }
}

extension FocusableTextField {
    class Coordinator: NSObject, UITextFieldDelegate {
        
        let fieldKind:C.FocusFieldType
        @Binding var text: String
        var didBecomeFirstResponder: Bool? = nil
        var didResignFirstResponder: Bool? = nil
        
        @Binding var focusedField: C.FocusFieldType?
        
        init(fieldKind: C.FocusFieldType, text: Binding<String>, focusedField: Binding<C.FocusFieldType?>) {
            self.fieldKind = fieldKind
            _text = text
            _focusedField = focusedField
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.focusedField = self.fieldKind
            }
        }
    }
}
