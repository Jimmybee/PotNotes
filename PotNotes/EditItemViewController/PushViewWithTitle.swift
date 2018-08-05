//
//  PushViewWithTitle.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 25/03/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import RxSwift

class PushViewWithTitle: UIView, TableModel {
    
    let bag = DisposeBag()
    var title = UILabel()
    var subtitle = UILabel()
    
    init(title: String, updateSubtitle: Observable<String>) {
        self.init()
        self.title.text = title
        updateSubtitle.debug("updateSubtitle").bind(to: subtitle.rx.text).disposed(by: bag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not coder compliant")
    }
    
    func setupLayout() {
        addSubview(title)
        addSubview(subtitle)
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(subtitle.snp.top).inset(-10)
        }
        
        subtitle.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
            
        }
    }
    
}
