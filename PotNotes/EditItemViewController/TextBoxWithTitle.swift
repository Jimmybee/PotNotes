//
//  TextBoxWithTitle.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 25/03/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import RxSwift

class TextBoxWithTitle: UIView, TableModel {
    var title = UILabel()
    var textField = UITextField()
    
    init(title: String, initialValue: String?) {
        self.init()
        self.title.text = title
        self.textField.text = initialValue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        //        self.backgroundColor = .gray
        textField.placeholder = "field name"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not coder compliant")
    }
    
    func setupLayout() {
        addSubview(title)
        addSubview(textField)
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(textField.snp.top).inset(-10)
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
            
        }
    }
}
