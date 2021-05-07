//
//  UIView+Extensions.swift
//  CardReader
//
//  Created by Khalid Asad on 2021-05-06.
//

import Foundation
import UIKit

extension UIStackView {
    
    static func stackView(spacing: CGFloat, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .center
        stackView.spacing = spacing
        return stackView
    }
}

extension UIButton {
    
    static func button(text: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: text), for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 5
        button.titleLabel?.textColor = .black
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.sizeToFit()
        return button
    }
}

extension UILabel {
    
    static func genericLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }
}
