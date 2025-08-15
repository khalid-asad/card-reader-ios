//
//  CardFormView.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-06.
//

import Foundation
import SwiftUI

public struct CardFormView: View {
    
    @Bindable private(set) var viewModel: ViewModel
    @State var isShowingSheet = false
    public var completion: ((CardDetails) -> Void)
    
    public init(viewModel: ViewModel, completion: @escaping ((CardDetails) -> Void )) {
        self.viewModel = viewModel
        self.completion = completion
    }
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack {
                CreditCardView(
                    viewModel:.init(
                        cardNumber: viewModel.cardNumber,
                        cardExpiryDate: viewModel.cardExpiryDate,
                        cardName: viewModel.cardName
                    )
                )
                .shadow(color: .primaryColor, radius: 5)
                .padding(.top, 60)
                                
                if viewModel.cardIndustry != .unknown {
                    Text(viewModel.cardIndustry.rawValue)
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
                        CardFormField(
                            fieldTitle: "Card Number",
                            text: $viewModel.cardNumber,
                            isCreditCardNumber: true
                        )
                        .keyboardType(.numberPad)
                        
                        CardFormField(
                            fieldTitle: "Card Name",
                            text: $viewModel.cardName,
                            autocapitalizationType: .words
                        )
                        .keyboardType(.alphabet)
                        
                        HStack(spacing: 20) {
                            CardFormField(
                                fieldTitle: "Card Expiry Date",
                                text: $viewModel.cardExpiryDate,
                                isExpiryDate: true
                            )
                            .keyboardType(.numberPad)
                            
                            CardFormField(
                                fieldTitle: "CVC #",
                                text: $viewModel.cvcNumber
                            )
                            .keyboardType(.numberPad)
                        }
                    }
                                        
                    Button(action: {
                        let cardInfo = viewModel.cardDetails
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
                        if let cardDetails {
                            viewModel.cardDetails = cardDetails
                        }
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
        CardFormView(
            viewModel: .init(),
            completion: { cardInfo in
                print("Name: \(cardInfo.name ?? "")")
                print("Number: \(cardInfo.number ?? "")")
                print("Expiry Date: \(cardInfo.expiryDate ?? "")")
                print("CVC: \(cardInfo.cvcNumber ?? "")")
            }
        )
    }
}
