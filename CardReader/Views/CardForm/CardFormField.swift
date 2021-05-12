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
    
    init(fieldTitle: String, text: Binding<String>, isSecure: Bool = false, autocapitalizationType: UITextAutocapitalizationType = .none, onEdit: (() -> Void)? = nil, isCreditCardNumber: Bool = false, isExpiryDate: Bool = false) {
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
                .font(.system(size: 16))
                .foregroundColor(isEditing ? .red : .primaryColor)
            
            if isSecure {
                SecureField("", text: $text, onCommit: { onEdit?() })
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .autocapitalization(autocapitalizationType)
                    .disableAutocorrection(true)
                    .border(Color(UIColor.separator))
                    .padding(.all, 4)
                    .background(Color.grayColor)
                    .cornerRadius(5)
            } else {
                TextField(
                    "",
                    text: $text,
                    onEditingChanged: { isEditing in
                        self.isEditing = isEditing
                        if !isEditing { onEdit?() }
                    })
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .autocapitalization(autocapitalizationType)
                    .disableAutocorrection(true)
                    .padding(.all, 4)
                    .background(Color.grayColor)
                    .cornerRadius(5)
//                    .onReceive(Just(text), perform: { newValue in
//                        if isCreditCardNumber {
//                            if [3, 8, 13].contains(text.count) && [4, 9, 15].contains(newValue.count) {
//                                self.text = newValue + " "
//                            } else if [5, 0, 15].contains(newValue.count) && [6, 11, 16].contains(text.count) {
//                                self.text = String(newValue.dropLast(1))
//                            } else {
//                                self.text = newValue
//                            }
//                        } else if isExpiryDate {
//                            self.text = newValue
//                        } else {
//                            self.text = newValue
//                        }
//                    })
            }
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
