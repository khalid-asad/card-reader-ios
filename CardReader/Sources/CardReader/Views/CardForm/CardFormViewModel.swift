//
//  CardFormViewModel.swift
//  CardReader
//
//  Created by Khalid Asad on 2025-08-15.
//

import Foundation
import SwiftUI

extension CardFormView {
    
    @Observable public class ViewModel {
        
        var cardNumber: String = ""
        var cardName: String = ""
        var cardExpiryDate: String = ""
        var cvcNumber: String = ""
                
        var colors: [Color]
        var formattedCardNumber: String { cardNumber == "" ? "4111 2222 3333 4444" : cardNumber }
        var cardIndustry: CardIndustry { .init(firstDigit: formattedCardNumber.first) }
        
        var cardDetails: CardDetails {
            get {
                return CardDetails(
                    numberWithDelimiters: cardNumber,
                    name: cardName,
                    expiryDate: cardExpiryDate,
                    cvcNumber: cvcNumber
                )
            }
            set {
                cardName = newValue.name ?? ""
                cardNumber = newValue.number ?? ""
                cardExpiryDate = newValue.expiryDate ?? ""
                cvcNumber = newValue.cvcNumber ?? ""
            }
        }
        
        public init(colors: [Color] = [.green, .blue, .black]) {
            self.colors = colors
        }
    }
}
