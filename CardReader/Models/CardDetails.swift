//
//  CardDetails.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-06.
//

import Foundation

public struct CardDetails: Equatable {
    var number: String?
    var expiryDate: String?
    var type: CardType
    var industry: CardIndustry
    
    public init(numberWithDelimiters: String? = nil, expiryDate: String? = nil) {
        self.number = numberWithDelimiters
        self.expiryDate = expiryDate
        self.type = CardType(number: numberWithDelimiters?.replacingOccurrences(of: " ", with: ""))
        self.industry = .init(firstDigit: numberWithDelimiters?.first)
    }
}

public enum CardType: String, CaseIterable {
    case masterCard = "MasterCard"
    case visa = "Visa"
    case amex = "Amex"
    case discover = "Discover"
    case dinersClubOrCarteBlanch = "Diner's Club/Carte Blanche"
    case unknown
    
    public init(number: String?) {
        guard let count = number?.count, count > 14 else {
            self = .unknown
            return
        }
        switch number?.first {
        case "3":
            if count == 15 {
                self = .amex
            } else if count == 14 {
                self = .dinersClubOrCarteBlanch
            } else {
                self = .unknown
            }
        case "4": self = (count == 13 || count == 16) ? .visa : .unknown
        case "5": self = count == 16 ? .masterCard : .unknown
        case "6": self = count == 16 ? .discover : .unknown
        default: self = .unknown
        }
    }
}

public enum CardIndustry: String, CaseIterable {
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
}
