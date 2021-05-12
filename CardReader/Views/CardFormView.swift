//
//  MainView.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-06.
//

import Foundation
import SwiftUI

public struct CardFormView: View {
    
    @State private var isShowingSheet = false
    @State private var cardNumber: String = ""
    @State private var cardExpiryDate: String = ""
    
    private var cardType: CardType {
        .init(number: cardNumber.replacingOccurrences(of: " ", with: ""))
    }
    private var cardIndustry: CardIndustry {
        .init(firstDigit: cardNumber.first)
    }
        
    public var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                CardFormField(fieldTitle: "Card Number", text: $cardNumber, isCreditCardNumber: true)
                    .keyboardType(.numberPad)
                
                CardFormField(fieldTitle: "Card Expiry Date", text: $cardExpiryDate, isExpiryDate: true)
                    .keyboardType(.numberPad)
                
                cardType.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                if cardIndustry != .unknown {
                    Text(cardIndustry.rawValue)
                        .font(.title)
                        .foregroundColor(.primaryColor)
                }
                
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Text("Scan card instead?")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }
                .padding(.top, 10)
            }
            .sheet(isPresented: $isShowingSheet) {
                CardReaderView() { cardDetails in
                    cardNumber = cardDetails?.number ?? ""
                    cardExpiryDate = cardDetails?.expiryDate ?? ""
                    isShowingSheet.toggle()
                }
                .edgesIgnoringSafeArea(.all)
            }
            .padding(.horizontal, 15)
            .padding(.top, 50)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardFormView()
    }
}
