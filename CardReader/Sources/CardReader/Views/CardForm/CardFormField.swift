//
//  CardFormField.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-07.
//

import Combine
import Foundation
import SwiftUI

public struct CardFormField: View {
    
    @Binding var text: String
    @State private var isEditing = false
    
    var onEdit: (() -> Void)?
    
    var fieldTitle: String
    var isSecure: Bool
    var autocapitalizationType: UITextAutocapitalizationType
    var isCreditCardNumber: Bool
    var isExpiryDate: Bool
    
    init(
        fieldTitle: String,
        text: Binding<String>,
        isSecure: Bool = false,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        onEdit: (() -> Void)? = nil,
        isCreditCardNumber: Bool = false,
        isExpiryDate: Bool = false
    ) {
        self.fieldTitle = fieldTitle
        self._text = text
        self.isSecure = isSecure
        self.autocapitalizationType = autocapitalizationType
        self.onEdit = onEdit
        self.isCreditCardNumber = isCreditCardNumber
        self.isExpiryDate = isExpiryDate
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(fieldTitle)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(isEditing ? .red : .primaryColor)
            
            Group {
                if isSecure {
                    SecureField("", text: $text, onCommit: { onEdit?() })
                } else {
                    TextField(
                        "",
                        text: $text,
                        onEditingChanged: { isEditing in
                            self.isEditing = isEditing
                            if !isEditing { onEdit?() }
                        }
                    )
//                        .onReceive(Just(text), perform: { newValue in
//                            if isCreditCardNumber {
//                                if [3, 8, 13].contains(text.count) && [4, 9, 15].contains(newValue.count) {
//                                    self.text = newValue + " "
//                                } else if [5, 0, 15].contains(newValue.count) && [6, 11, 16].contains(text.count) {
//                                    self.text = String(newValue.dropLast(1))
//                                } else {
//                                    self.text = newValue
//                                }
//                            } else if isExpiryDate {
//                                self.text = newValue
//                            } else {
//                                self.text = newValue
//                            }
//                        })
                }
            }
            .font(.system(size: 20, weight: .bold, design: .monospaced))
            .foregroundColor(.textFieldTextColor)
            .autocapitalization(autocapitalizationType)
            .disableAutocorrection(true)
            .padding(.all, 6)
            .background(Color.textFieldColor)
            .cornerRadius(5)
        }
    }
}

//struct CardFormField_Previews: PreviewProvider {
//
//    @State var text: String
//
//    static var previews: some View {
//        CardFormField(fieldTitle: "Card number", text: $text)
//    }
//}
