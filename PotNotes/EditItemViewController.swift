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
import SnapKit
import RxGesture

class EditItemViewController: UIViewController {
    
    let bag = DisposeBag()
    
    var item: PotteryItem
    var tableView = UITableView()
    
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
    
    override func viewDidLoad() {
         setupTableView()
        setupRx()
    }
    
    var name = Variable<String?>("")
    var potteryType = Variable<PotteryType?>(nil)

    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let nameCell = TextBoxWithTitle(title: "Name")
        nameCell.textField.rx.text.bind(to: name).disposed(by: bag)
        
        let objectCell = PushViewWithTitle(title: "Object Type")
        objectCell.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: { (_) in
                    let publishSubject = PublishSubject<PotteryType>()
                    let types: [PotteryType] = [PotteryType(title: "t1", id: 1), PotteryType(title: "t2", id: 2)]
                    let model = ListSelectionModel(choices: types, publishChoice: publishSubject)
                    let vc = ListSelectionViewController(listModel: model)
                    publishSubject.subscribe(onNext: { (potteryType) in
                        self.potteryType.value = potteryType
                    })
                    .disposed(by: self.bag)
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                .disposed(by: bag)
        
        let textBoxViews: Observable<[UIView]> = Observable.of([nameCell, objectCell])
        
        
        tableView.register(EditFieldTableCell.self, forCellReuseIdentifier: EditFieldTableCell.id)
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = .darkGray
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        
        textBoxViews
            .debug()
            .bind(to: tableView.rx.items(cellIdentifier: EditFieldTableCell.id, cellType: EditFieldTableCell.self)) { row, model, cell in
//                if let view = model as? UIView {
                    cell.textView = model
//                }
            }
            .disposed(by: bag)
    }
    
    func setupRx() {
        Observable.combineLatest(name.asObservable(), potteryType.asObservable().map{ $0?.title }) { (name1, object1) -> String in
            return (name1 ?? "") + " " + (object1 ?? "")
            }
            .debug()
            .subscribe()
            .disposed(by: bag)

    }
    
    
}


protocol TableModel {
    
}

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



class PushViewWithTitle: UIView, TableModel {
    
    var title = UILabel()
    var subtitle = UILabel()
    
    init(title: String) {
        self.init()
        self.title.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        subtitle.text = "Please select"
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

class TextBoxWithTitle: UIView, TableModel {
    var title = UILabel()
    var textField = UITextField()
    
    init(title: String) {
        self.init()
        self.title.text = title
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



