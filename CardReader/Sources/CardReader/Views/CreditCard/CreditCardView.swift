//
//  CreditCardView.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-12.
//

import SwiftUI

public struct CreditCardView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
            Spacer()
            
            Image("chip", bundle: .module)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            
            Text(viewModel.formattedCardNumber)
                .font(.system(size: 26, weight: .bold, design: .monospaced))
            
            Spacer()
            
            HStack(alignment: .center) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Name")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                    
                    Text(viewModel.formattedCardName)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                }
                
                Spacer(minLength: 10)
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Exp. Date")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                    
                    Text(viewModel.formattedCardExpiryDate)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                }
                
                Spacer(minLength: 10)
                
                viewModel.cardType.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
            }
        }
        .padding(.init(top: 8, leading: 16, bottom: 4, trailing: 16))
        .foregroundColor(viewModel.textColor)
        .background(LinearGradient(gradient: Gradient(colors: viewModel.backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(7)
        .frame(width: 340, height: 200, alignment: .center)
    }
}

struct CreditCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CreditCardView(
            viewModel: .init(
                cardNumber: "4111 2222 3333 4444",
                cardExpiryDate: "05/2021",
                cardName: "John Doe"
            )
        )
    }
}
