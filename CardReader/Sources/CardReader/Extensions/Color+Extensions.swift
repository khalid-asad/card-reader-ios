//
//  Color+Extensions.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-12.
//

import Foundation
import SwiftUI

public extension UIColor {
    
    static var darkGrayColor: UIColor {
        UIColor(red: 21.0/255.0, green: 21.0/255.0, blue: 21.0/255.0, alpha: 1.0)
    }
    
    static var grayColor: UIColor {
        UIColor(red: 187/255.0, green: 187/255.0, blue: 187/255.0, alpha: 1.0)
    }
    
    static var darkerGrayColor: UIColor {
        UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1)
    }
}

public extension Color {
    
    static var isDarkInterfaceStyle: Bool {
        primaryColor == .white
    }
    
    static var primaryColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? .white : .black })
    }
    
    static var backgroundColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? .darkGrayColor : .white })
    }
        
    static var textFieldColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? .darkerGrayColor : .grayColor })
    }
    
    static var textFieldTextColor: Color {
        Color(UIColor { $0.userInterfaceStyle == .dark ? .white : .black })
    }
    
    static var buttonColor: Color {
        Color(UIColor(red: 50.0/255.0, green: 130/255.0, blue: 184/255.0, alpha: 1))
    }
}
