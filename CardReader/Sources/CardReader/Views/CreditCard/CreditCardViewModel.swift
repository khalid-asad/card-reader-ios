//
//  CreditCardViewModel.swift
//  CardReader
//
//  Created by Khalid Asad on 2025-08-14.
//

import SwiftUI

extension CreditCardView {
    
    public class ViewModel: ObservableObject {
                
        @Published var cardNumber: String
        @Published var cardExpiryDate: String
        @Published var cardName: String
        
        var backgroundColors: [Color]
        var textColor: Color
        
        var formattedCardNumber: String {
            cardNumber == "" ? "4111 2222 3333 4444" : cardNumber
        }
        var formattedCardName: String {
            cardName == "" ? "John Doe" : cardName
        }
        var formattedCardExpiryDate: String {
            cardExpiryDate == "" ? "05/2021" : cardExpiryDate
        }
        var cardType: CardType {
            .init(number: formattedCardNumber.replacingOccurrences(of: " ", with: ""))
        }
        
        public init(
            backgroundColors: [Color] = [.red, .orange],
            textColor: Color = .white,
            cardNumber: String,
            cardExpiryDate: String,
            cardName: String
        ) {
            self.backgroundColors = backgroundColors
            self.textColor = textColor
            self.cardNumber = cardNumber
            self.cardExpiryDate = cardExpiryDate
            self.cardName = cardName
        }
    }
}
