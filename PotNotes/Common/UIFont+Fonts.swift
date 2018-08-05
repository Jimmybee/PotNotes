//
//  UIFont+Fonts.swift
//  FieldMargin
//
//  Created by Konrad Em. on 09/05/16.
//  Copyright © 2016 Untitiled Kingdom. All rights reserved.
//

import UIKit

protocol FontType {
    
    // func fontWithSize(_ size:CGFloat) -> UIFont

    var rawValue : String { get }
}

extension FontType {
    func fontWithSize(_ size:CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}

enum MontserratFont: String, FontType {
    case family     = "Montserrat"
    case regular    = "Montserrat-Regular"
    case bold       = "Montserrat-Bold"
    case semibold   = "Montserrat-SemiBold"
    case light      = "Montserrat-Light"
    case hairline   = "Montserrat-Hairline"
}

enum RobotoFont: String, FontType {
    case regular    = "Roboto-Regular"
}
