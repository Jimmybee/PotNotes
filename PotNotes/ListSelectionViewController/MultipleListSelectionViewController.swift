//
//  ListSelectionViewController.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 24/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class MultipleListSelectionViewController<T: ListSelection>: UIViewController {
    
    let bag = DisposeBag()
    let listModel: MulitpleListSelectionModel<T>
    
    let tableView = UITableView()

    init(listModel: MulitpleListSelectionModel<T>) {
        self.listModel = listModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavigation()
    }
    
    private func setupTable() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
        
        listModel.model
            .bind(to: tableView.rx.items(cellIdentifier: "test", cellType: UITableViewCell.self)) { row, model, cell in
                cell.textLabel?.text = model.listItem.title
                cell.accessoryType = model.selected ? .checkmark : .none
            }
            .disposed(by: bag)
        
        
        tableView.rx.modelSelected(MulitpleListSelectionModel.TableModel.self)
            .subscribe(onNext: { (selection) in
                self.listModel.selected(element: selection.listItem)
            })
            .disposed(by: bag)
    }
    
    private func setupNavigation() {
        let bttn = UIBarButtonItem(title: "Set", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = bttn
        bttn.rx.tap
            .subscribe(onNext: { [unowned self] (_) in
                self.listModel.publishSelection()
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: bag)
    }
    
}

protocol ListSelection: Hashable {
    var title: String? { get }
}

class MulitpleListSelectionModel<T: ListSelection> {
    
    struct TableModel {
        let listItem: T
        let selected: Bool
    }
    
    let publishChoice = PublishSubject<Set<T>>()
    
    var model: Observable<[TableModel]> {
        return Observable.combineLatest(selection.asObservable(), choices) { (currentSelected, listChoices) -> [TableModel] in
            return listChoices.map{ TableModel(listItem: $0, selected: currentSelected.contains($0))   }
        }
    }
    private let selection = Variable<Set<T>>([])
    private let choices: Observable<[T]>
    
    init(choices: Observable<[T]>, selected: Set<T>) {
        self.choices = choices
        self.selection.value = selected
    }
    
    func selected(element: T) {
        if selection.value.contains(element) {
            selection.value.remove(element)
        } else {
            selection.value.insert(element)
        }
    }
    
    func publishSelection() {
        publishChoice.onNext(selection.value)
    }
}
