//
//  ReusableViewFromNib.swift
//  FieldMargin
//
//  Created by Jimmy Birtwell on 06/03/2018.
//  Copyright © 2018 fieldmargin. All rights reserved.
//

import UIKit

class ReusableViewFromXib: UIView {
    var customView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let className = String(describing: type(of: self))
        
        self.customView = Bundle.main.loadNibNamed(className, owner: self, options: nil)!.first as? UIView
        self.customView?.frame = self.bounds
        
        if frame.isEmpty == true {
            self.bounds = (self.customView?.bounds)!
        }
        
        self.addSubview(self.customView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let className = String(describing: type(of: self))
        
        self.customView = Bundle.main.loadNibNamed(className, owner: self, options: nil)!.first as? UIView
        self.customView?.frame = self.bounds
        
        self.addSubview(self.customView!)
    }
}

// MARK: Material Design
extension UIView {
    
    func addShadowWith(elevation: Int) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = CGFloat(elevation)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: elevation)
    }
    
}
