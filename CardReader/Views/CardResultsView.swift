//
//  MainView.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-06.
//

import Foundation
import SwiftUI

public struct CardResultsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    private var color: Color {
        colorScheme == .dark ? .white : .black
    }
    @State private var isShowingSheet = false
    @State private var cardDetails: CardDetails?
    
    public var body: some View {
        NavigationView {
            VStack {
                if let cardDetails = cardDetails {
                    Text("Card Number:\n\(cardDetails.number ?? "")")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(color)
                        .multilineTextAlignment(.center)
                        .padding(10)

                    Text("Expiry Date:\n\(cardDetails.expiryDate ?? "")")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(color)
                        .multilineTextAlignment(.center)
                        .padding(10)

                    Text("Card Type:\n\(cardDetails.type.rawValue)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(color)
                        .multilineTextAlignment(.center)
                        .padding(10)

                    Text("Card Industry:\n\(cardDetails.industry.rawValue)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(color)
                        .multilineTextAlignment(.center)
                        .padding(10)
                }
                
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Text("Tap to Start Credit Card reading!")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 100)
            }
            .sheet(isPresented: $isShowingSheet) {
                CardReaderView() { cardDetails in
                    self.cardDetails = cardDetails
                    isShowingSheet.toggle()
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardResultsView()
    }
}
