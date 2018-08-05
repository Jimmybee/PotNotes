//
//  Regular.swift
//  FieldMargin
//
//  Created by Jimmy Birtwell on 12/10/2017.
//  Copyright © 2017 fieldmargin. All rights reserved.
//

import Foundation
import UIKit

/// small = 12
/// medium = 14
/// title = NavyBlue / bold
/// subtitle = navyblue / light
/// paragraph = lightGray / regular

struct Style {
    enum Size: CGFloat {
        case small = 12, medium = 14, large = 18
    }
    enum Font {
        case paragraph, subtitle, title, error
        
        var asString: String {
            switch self {
            case .paragraph:
                return MontserratFont.regular.rawValue
            case .subtitle:
                return MontserratFont.regular.rawValue
            case .title:
                return MontserratFont.bold.rawValue
            case .error:
                return MontserratFont.bold.rawValue
            }
        }
        var color: UIColor {
            switch self {
            case .paragraph:
                return UIColor(hexString: "747474")
            case .error:
                return UIColor.errorRed()
            case .subtitle:
                return UIColor.navyBlue()
            case .title:
                return UIColor.navyBlue()
            }
        }
    }
}

class StyleLabel: UILabel {
    var fontStyle: Style.Font = .paragraph
    var size: Style.Size = .medium
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setDefaultValues()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaultValues()
        setup()
    }
    
    func setDefaultValues() {
        fontStyle = Style.Font.error
        size = Style.Size.small
    }
    
    func setup() {
        font = UIFont(name: fontStyle.asString, size: size.rawValue)
        textColor = fontStyle.color
    }
}

class SmallErrorLabel: StyleLabel {
    override func setDefaultValues() {
        fontStyle = Style.Font.error
        size = Style.Size.small
    }
}


class MediumSubtitleLabel: StyleLabel {
    override func setDefaultValues() {
        fontStyle = Style.Font.subtitle
        size = Style.Size.medium
    }
}

class MediumTitleLabel: StyleLabel {
    override func setDefaultValues() {
        fontStyle = Style.Font.title
        size = Style.Size.medium
    }
}

class MediumParagraphLabel: StyleLabel {
    override func setDefaultValues() {
        fontStyle = Style.Font.paragraph
        size = Style.Size.medium
    }
}


class LargeSubtitleLabel: StyleLabel {
    override func setDefaultValues() {
        fontStyle = Style.Font.subtitle
        size = Style.Size.large
    }
}

class LargeTitleLabel: StyleLabel {
    override func setDefaultValues() {
        fontStyle = Style.Font.title
        size = Style.Size.large
    }
}

class LargeParagraphLabel: StyleLabel {
    override func setDefaultValues() {
        fontStyle = Style.Font.paragraph
        size = Style.Size.large
    }
}
