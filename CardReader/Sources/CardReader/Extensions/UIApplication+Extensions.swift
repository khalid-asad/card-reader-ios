//
//  UIApplication+Extensions.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-12.
//

import Foundation
import UIKit

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
