//
//  Color+Extensions.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-12.
//

import Foundation
import SwiftUI

public extension Color {
    
    static var isDarkInterfaceStyle: Bool {
        primaryColor == .white
    }
    
    static var primaryColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? .white : .black })
    }
    
    static var backgroundColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? .darkGray : .white })
    }
    
    static var grayColor: Color {
        Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    }
}
