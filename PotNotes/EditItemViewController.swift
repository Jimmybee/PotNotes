//
//  EditItemViewController.swift
//  PotNotes
//
//  Created by James Birtwell on 21/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EditItemViewController: UIViewController {
    
    var item: PotteryItem
    
    init(item: PotteryItem? = nil) {
        self.item = item ?? PotteryItem()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    
}

class TextField: UIView {
    
    var title: UILabel = UILabel()
    var textField: UITextField = UITextField()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect? = nil, vari: Variable<String>) {
        self.init(frame: .zero)
        vari.asObservable().bind(to: textField.rx.text)
        
    }
    
    func setupConstraints() {
        addSubview(title)
        addSubview(textField)
    }
    
}



