//
//  CardDetails.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-06.
//

import Foundation
import SwiftUI

public struct CardDetails: Hashable, Identifiable {
    public var number: String?
    public var name: String?
    public var expiryDate: String?
    public var cvcNumber: String?
    public var type: CardType
    public var industry: CardIndustry
    
    public init(numberWithDelimiters: String? = nil, name: String? = nil, expiryDate: String? = nil, cvcNumber: String? = nil) {
        self.number = numberWithDelimiters
        self.name = name
        self.expiryDate = expiryDate
        self.cvcNumber = cvcNumber
        self.type = CardType(number: numberWithDelimiters?.replacingOccurrences(of: " ", with: ""))
        self.industry = .init(firstDigit: numberWithDelimiters?.first)
    }
    
    public var id: Int { hashValue }
}

public enum CardType: String, CaseIterable, Identifiable {
    case masterCard = "MasterCard"
    case visa = "Visa"
    case amex = "Amex"
    case discover = "Discover"
    case dinersClubOrCarteBlanche = "Diner's Club/Carte Blanche"
    case unknown
    
    public init(number: String?) {
        guard let count = number?.count, count >= 14 else {
            self = .unknown
            return
        }
        switch number?.first {
        case "3":
            if count == 15 {
                self = .amex
            } else if count == 14 {
                self = .dinersClubOrCarteBlanche
            } else {
                self = .unknown
            }
        case "4": self = (count == 13 || count == 16) ? .visa : .unknown
        case "5": self = count == 16 ? .masterCard : .unknown
        case "6": self = count == 16 ? .discover : .unknown
        default: self = .unknown
        }
    }
    
    public var id: Int { hashValue }
    
    public var image: Image? {
        switch self {
        case .masterCard: return Image("mastercard-\(Color.isDarkInterfaceStyle ? "white" : "dark")-bg", bundle: .module)
        case .visa: return Image("visa", bundle: .module)
        case .amex: return Image("amex", bundle: .module)
        case .discover: return Image("discover", bundle: .module)
        case .dinersClubOrCarteBlanche: return Image("dinersclub", bundle: .module)
        case .unknown: return nil
        }
    }
}

public enum CardIndustry: String, CaseIterable, Identifiable {
    case industry = "ISO/TC 68 and other industry assignments"
    case airlines = "Airlines"
    case airlinesFinancialAndFuture = "Airlines, financial and other future industry assignments"
    case travelAndEntertainment = "Travel and entertainment"
    case bankingAndFinancial = "Banking and financial"
    case merchandisingAndBanking = "Merchandising and banking/financial"
    case petroleum = "Petroleum and other future industry assignments"
    case healthcareAndTelecom = "Healthcare, telecommunications and other future industry assignments"
    case national = "For assignment by national standards bodies"
    case unknown
    
    public init(firstDigit: String.Element?) {
        switch firstDigit {
        case "0": self = .industry
        case "1": self = .airlines
        case "2": self = .airlinesFinancialAndFuture
        case "3": self = .travelAndEntertainment
        case "4", "5": self = .bankingAndFinancial
        case "6": self = .merchandisingAndBanking
        case "7": self = .petroleum
        case "8": self = .healthcareAndTelecom
        case "9": self = .national
        default: self = .unknown
        }
    }
    
    public var id: Int { hashValue }
}
