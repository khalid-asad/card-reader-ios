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
    @State private var cardName: String = ""
    
    private var formattedCardNumber: String { cardNumber == "" ? "4111 2222 3333 4444" : cardNumber }
    private var cardIndustry: CardIndustry { .init(firstDigit: formattedCardNumber.first) }
        
    public var body: some View {
        ScrollView(.vertical) {
            VStack {
                CreditCardView(backgroundColors: [.blue, .black], cardNumber: $cardNumber, cardExpiryDate: $cardExpiryDate, cardName: $cardName)
                    .shadow(color: .primaryColor, radius: 5)
                    .padding(.top, 30)
                
                Spacer(minLength: 30)
                
                if cardIndustry != .unknown {
                    Text(cardIndustry.rawValue)
                        .font(.system(size: 14))
                        .foregroundColor(.primaryColor)
                }
                
                VStack(alignment: .leading) {
                    CardFormField(fieldTitle: "Card Number", text: $cardNumber, isCreditCardNumber: true)
                        .keyboardType(.numberPad)
                    
                    CardFormField(fieldTitle: "Card Expiry Date", text: $cardExpiryDate, isExpiryDate: true)
                        .keyboardType(.numberPad)
                    
                    CardFormField(fieldTitle: "Card Name", text: $cardName, autocapitalizationType: .words)
                        .keyboardType(.alphabet)
                    
                    Button {
                        isShowingSheet.toggle()
                    } label: {
                        Text("Scan card instead?")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.top, 20)
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
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardFormView()
    }
}
