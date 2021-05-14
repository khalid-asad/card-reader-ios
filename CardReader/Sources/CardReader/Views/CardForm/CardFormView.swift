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
    @State private var cardName: String = ""
    @State private var cardExpiryDate: String = ""
    @State private var cvcNumber: String = ""
    
    public var completion: ((CardDetails) -> Void)
    
    private var colors: [Color]
    private var formattedCardNumber: String { cardNumber == "" ? "4111 2222 3333 4444" : cardNumber }
    private var cardIndustry: CardIndustry { .init(firstDigit: formattedCardNumber.first) }
        
    public init(colors: [Color] = [.green, .blue, .black], completion: @escaping ((CardDetails) -> Void )) {
        self.colors = colors
        self.completion = completion
    }
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack {
                CreditCardView(backgroundColors: colors, cardNumber: $cardNumber, cardExpiryDate: $cardExpiryDate, cardName: $cardName)
                    .shadow(color: .primaryColor, radius: 5)
                    .padding(.top, 60)
                                
                if cardIndustry != .unknown {
                    Text(cardIndustry.rawValue)
                        .font(.system(size: 14))
                        .foregroundColor(.primaryColor)
                        .padding(.top, 10)
                }
                
                Button(action: {
                    isShowingSheet.toggle()
                }) {
                    HStack(alignment: .center) {
                        Image("scan", bundle: .module)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                        
                        Text("Scan Card")
                            .font(.system(size: 26, weight: .bold, design: .monospaced))
                    }
                    .foregroundColor(.primaryColor)
                    .padding(.all, 12)
                    .background(Color.textFieldColor)
                    .cornerRadius(16)
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                                
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 10) {
                        CardFormField(fieldTitle: "Card Number", text: $cardNumber, isCreditCardNumber: true)
                            .keyboardType(.numberPad)
                                            
                        CardFormField(fieldTitle: "Card Name", text: $cardName, autocapitalizationType: .words)
                            .keyboardType(.alphabet)
                        
                        HStack(spacing: 20) {
                            CardFormField(fieldTitle: "Card Expiry Date", text: $cardExpiryDate, isExpiryDate: true)
                                .keyboardType(.numberPad)
                            
                            CardFormField(fieldTitle: "CVC #", text: $cvcNumber)
                                .keyboardType(.numberPad)
                        }
                    }
                                        
                    Button(action: {
                        let cardInfo = CardDetails(
                            numberWithDelimiters: cardNumber,
                            name: cardName,
                            expiryDate: cardExpiryDate,
                            cvcNumber: cvcNumber
                        )
                        completion(cardInfo)
                    }) {
                        HStack(alignment: .center) {
                            Text("Submit")
                                .font(.system(size: 26, weight: .bold, design: .default))
                        }
                        .foregroundColor(Color.white)
                        .padding(.all, 12)
                        .background(Color.buttonColor)
                        .cornerRadius(12)
                    }
                    .padding(.top, 26)
                }
                .sheet(isPresented: $isShowingSheet) {
                    CardReaderView() { cardDetails in
                        print(cardDetails ?? "")
                        cardNumber = cardDetails?.number ?? ""
                        cardExpiryDate = cardDetails?.expiryDate ?? ""
                        cardName = cardDetails?.name ?? ""
                        isShowingSheet.toggle()
                    }
                    .edgesIgnoringSafeArea(.all)
                }
                .padding(.horizontal, 15)
                .padding(.top, 10)
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .background(Color.backgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardFormView(completion: { _ in })
    }
}
