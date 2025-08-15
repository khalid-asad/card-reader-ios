//
//  CardFormViewModel.swift
//  CardReader
//
//  Created by Khalid Asad on 2025-08-15.
//

import Foundation
import SwiftUI

extension CardFormView {
    
    public class ViewModel: ObservableObject {
        
        @Published var cardNumber: String = ""
        @Published var cardName: String = ""
        @Published var cardExpiryDate: String = ""
        @Published var cvcNumber: String = ""
                
        var colors: [Color]
        var formattedCardNumber: String { cardNumber == "" ? "4111 2222 3333 4444" : cardNumber }
        var cardIndustry: CardIndustry { .init(firstDigit: formattedCardNumber.first) }
        
        var cardDtails: CardDetails {
            return CardDetails(
                numberWithDelimiters: cardNumber,
                name: cardName,
                expiryDate: cardExpiryDate,
                cvcNumber: cvcNumber
            )
        }
        
        public init(colors: [Color] = [.green, .blue, .black]) {
            self.colors = colors
        }
    }
}
