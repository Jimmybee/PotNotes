//
//  CustomToolBar.swift
//  MyWarmup
//
//  Created by Wasil Ahmed on 09/08/2016.
//  Copyright © 2016 Warmup Plc. All rights reserved.
//

import UIKit

class CustomToolBar: UIToolbar {
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        barStyle = .default
        isTranslucent = true
        sizeToFit()
        isUserInteractionEnabled = true
        
        leftButton.title = "Cancel"
        leftButton.isEnabled = true
        
        rightButton.title = "Done"
        rightButton.isEnabled = true
        
        setItems([leftButton, spaceButton, rightButton], animated: false)
    }
    
    
    // MARK: - Property Accessors
    
    fileprivate(set) lazy var rightButton: UIBarButtonItem = {
        let rightButton = UIBarButtonItem()
        rightButton.tintColor = UIColor.black
        return rightButton
    }()
    
    fileprivate(set) lazy var leftButton: UIBarButtonItem = {
        let leftButton = UIBarButtonItem()
        leftButton.tintColor = UIColor.black
        return leftButton
    }()
    
    fileprivate(set) lazy var spaceButton: UIBarButtonItem = {
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        return spaceButton
    }()
    
    
}

class CustomToolBarWithTwoRightButtons : CustomToolBar {
    
    fileprivate(set) lazy var leftRightButton: UIBarButtonItem = {
        let leftRightButton = UIBarButtonItem()
        leftRightButton.tintColor = UIColor.black
        return leftRightButton
    }()
    
    override func setup() {
        barStyle = .default
        isTranslucent = true
        sizeToFit()
        isUserInteractionEnabled = true
        
        setItems([leftButton, spaceButton, leftRightButton, rightButton], animated: false)
    }
    
}
