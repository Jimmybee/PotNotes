//
//  EditFieldTableCell.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 25/03/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit

class EditFieldTableCell: UITableViewCell {
    static let id = "EditFieldTableCell"
    
    var textView: UIView? {
        didSet {
            addView(textView!)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func addView(_ view:UIView) {
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
