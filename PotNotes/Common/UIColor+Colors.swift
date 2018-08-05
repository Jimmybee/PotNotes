//
//  UIColor+Colors.swift
//  FieldMargin
//
//  Created by Konrad Em. on 29/04/16.
//  Copyright © 2016 Untitiled Kingdom. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct primary {
        static var main: UIColor {
            return UIColor(hexString: "#6A7381")
        }
        static var dark: UIColor {
            return UIColor(hexString:  "363A41")
        }
    }
    
    struct text {
        static var disabled: UIColor {
            return UIColor(hexString: "#AAAAAA")
        }
        static var darkGray: UIColor {
            return UIColor(hexString: "#696969")
        }
        static var usersNameLabel: UIColor {
            return UIColor(hexString: "#273646")
        }
    }
    
    struct background {
        static var light: UIColor {
            return UIColor(hexString: "#f3f3f0")
        }
        static var usersHeader: UIColor {
            return UIColor(hexString: "#e3e3e3")
        }
    }
    
    struct line {
        static var dark : UIColor {
            return UIColor(hexString: "#dddddd")
        }
    }
    
    
    
//    - Wheat: #fcd506
//    - Gold: #ebbc00
//    - Sky: #4da4da
//    - Dark blue: #2c3e50
    
    
    // To be used on highlighted text that can be touched (eg: tap here to add a note)
    class func actionableTextColor() -> UIColor {
        return UIColor(hexString: "#56a4db") // light blue
    }
    
    class func fieldsOfGoldColor() -> UIColor {
        return UIColor(hexString: "#ebbc00")
    }
    
    class func darkSkyBlueColor() -> UIColor {
        return UIColor(hexString:"#2c3e50")
    }
    
    class func transparentDarkSkyBlueColor() -> UIColor {
        return UIColor.darkSkyBlueColor().withAlphaComponent(0.2)
    }

    class func offlineAreaStrokeColor() -> UIColor {
        return UIColor.darkSkyBlueColor()
    }

    class func offlineAreaFillColor() -> UIColor {
        return UIColor.darkSkyBlueColor().withAlphaComponent(0.75)
    }

    class func dimmedWhite() -> UIColor {
        return UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    }
    
    class func lightBlue() -> UIColor {
        return UIColor(red: 219.0/255.0, green: 235.0/255.0, blue: 243.0/255.0, alpha: 1.0)
    }
    
    class func transparentWhite() -> UIColor {
        return UIColor.white.withAlphaComponent(0.3)
    }
    
    class func transparentDimmedWhite() -> UIColor {
        return UIColor.dimmedWhite().withAlphaComponent(0.4)
    }
    
    class func errorRed() -> UIColor {
        return UIColor(hexString: "#d94e29")
    }
    
    class func transparentErrorRed() -> UIColor {
        return UIColor.errorRed().withAlphaComponent(0.3)
    }
    
    class func smokeGrayColor() -> UIColor {
        return UIColor(red: 199.0/255.0, green: 199.0/255.0, blue: 204.0/255.0, alpha: 1.0)
    }
    
    class func navyBlue() -> UIColor {
        return UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0)
    }
    
    class func archivedOrange() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 150.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    
    class func unarchiveGreen() -> UIColor {
        return UIColor(red: 39.0/255, green: 174.0/255, blue: 96.0/255, alpha: 1.0)
    }
    
    // UI colors
    static var defaultOverlayColor : UIColor {
        get {
            return UIColor.white
        }
    }
    static var defaultPreviewOverlayColor : UIColor {
        get {
            return UIColor(hexString: "#4da4da")
        }
    }
    class func typeNote() -> UIColor {
        return UIColor.defaultOverlayColor
    }
    class func typeArchivedNote() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 183.0/255.0, blue: 81.0/255.0, alpha: 1.0)
    }
    class func outlineBlue() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 199.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    static var backgroundGray: UIColor {
        return UIColor(hexString: "F5F5F2")
    }

    /// Types
    enum TypeColor : String {
        
        case red    = "#c93e27"
        case orange = "#c76026"
        case yellow = "#edc233" // field
        case green  = "#55a548" // trees
        case sage   = "#90a519"
        case blue   = "#288adb" // water
        case violet = "#8363db"
        case purple = "#983987"
        case brown  = "#b37e34"
        
        var color : UIColor {
            return UIColor(hexString: self.rawValue)
        }
        
        /// Use this when showing related-UI
        static let list : [TypeColor] = [
            TypeColor.red,
            TypeColor.orange,
            TypeColor.yellow,
            TypeColor.green,
            TypeColor.sage,
            TypeColor.blue,
            TypeColor.violet,
            TypeColor.purple,
            TypeColor.brown
        ]
    }
    
}

