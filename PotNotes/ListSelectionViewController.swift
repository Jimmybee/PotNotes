//
//  ListSelectionViewController.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 24/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import RxSwift


class ListSelectionViewController<T: ListSelection>: UIViewController {
    
    let bag = DisposeBag()
    let listModel: ListSelectionModel<T>
    
    let tableView = UITableView()

//    init(listModel: [T]) {
//        self.listModel = listModel
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init(listModel: ListSelectionModel<T>) {
        self.listModel = listModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
        Observable.of(listModel.choices)
            .bind(to: tableView.rx.items(cellIdentifier: "test", cellType: UITableViewCell.self)) { row, model, cell in
                cell.textLabel?.text = model.title
            }
            .disposed(by: bag)
        
        
        tableView.rx.modelSelected(T.self)
            .subscribe(onNext: { (selection) in
                self.listModel.selected(element: selection)
            })
            .disposed(by: bag)

    }
    
}

protocol ListSelection {
    var title: String { get }
}


class ListSelectionModel<T: ListSelection> {
    let publishChoice: PublishSubject<T>
    let choices: [T]
    
    init(choices: [T], publishChoice: PublishSubject<T>) {
        self.choices = choices
        self.publishChoice = publishChoice
    }
    
    func selected(element: T) {
        publishChoice.onNext(element)
    }
}
