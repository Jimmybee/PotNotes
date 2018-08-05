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
    
    private(set) lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.showsSelectionIndicator = true
        return picker
    }()
    
    lazy var toolBar: CustomToolBar = {
        let toolBar = CustomToolBar()
        toolBar.leftButton.action = #selector(dismissPressed)
        toolBar.rightButton.action = #selector(applyPressed)
        return toolBar
    }()
    
    let bag = DisposeBag()
    
    var item: Variable<PotteryItem>
    var tableView = UITableView()
    
    init(item: PotteryItem? = nil) {
        self.item = Variable<PotteryItem>(item ?? PotteryItem())
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
        setupPicker()
        setupRx()
        setupNavigation() 
    }
    
    enum PickerContent {
        case residentialStatus
        case addressLines
    }
    
    var pickerContentType: PickerContent = .addressLines {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    var pickerContent: [String] {
        switch self.pickerContentType {
        case .residentialStatus:
            return ["asd", "dsa"]
        case .addressLines:
            return ["pne", "twe"]
        }
    }
    
    var name: Observable<String?> {
        return item.asObservable().map { $0.name }
    }
    var potteryType: Observable<PotteryType?> {
        return item.asObservable().map { $0.type }
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let nameCell = TextBoxWithTitle(title: "Name", initialValue: item.value.name)
        nameCell.textField.rx.text
            .subscribe(onNext: { (text) in
                self.item.value = self.item.value.update(name: text!)
                })
                .disposed(by: bag)

        let titleForCell = item.asObservable().map({$0.type?.title}).map({ return $0 == nil ? "Please Select" : $0! })
        let objectCell = PushViewWithTitle(title: "Object Type", updateSubtitle: titleForCell)
        objectCell.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: { (_) in
                    let publishSubject = PublishSubject<PotteryType>()
                    let types = PotteryType.obseravble
                    let model = ListSelectionModel(choices: types, publishChoice: publishSubject)
                    let vc = ListSelectionViewController(listModel: model)
                    publishSubject.subscribe(onNext: { (potteryType) in
                        self.item.value = self.item.value.update(potteryType: potteryType)
                    })
                    .disposed(by: self.bag)
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                .disposed(by: bag)
        
        
        let pickerCell = PushViewWithTitle(title: "Height", updateSubtitle: Observable.of("2"))
        pickerCell.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] (_) in
                self?.displayPickerAs(open: true)
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.view.layoutIfNeeded()
                }
            })
            .disposed(by: bag)
        
        let textBoxViews: Observable<[UIView]> = Observable.of([nameCell, objectCell, pickerCell])

        tableView.register(EditFieldTableCell.self, forCellReuseIdentifier: EditFieldTableCell.id)
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = .darkGray
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        
        textBoxViews
            .debug()
            .bind(to: tableView.rx.items(cellIdentifier: EditFieldTableCell.id, cellType: EditFieldTableCell.self)) { row, model, cell in
                    cell.textView = model
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
    
    func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.rx.tap.take(1)
            .withLatestFrom(item.asObservable())
            .flatMapLatest { (item) -> Observable<PotteryItem> in
                return item.save()
            }
            .subscribe(onNext: { [unowned self] (item) in
                //Push to detail screen
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: bag)
    }
    
}


extension EditItemViewController: PickerViewController {
    var scrollView: UIScrollView! {
        return tableView
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerContent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerContent[row]
    }
    
    func setupPicker() {
        setupConstraints()
        displayPickerAs(open: false)
    }
    
    @objc func applyPressed() {
        displayPickerAs(open: false)
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
//        showManualForm()
//        updateModelFromPicker(pickerView.selectedRow(inComponent: 0))
    }
    
    @objc func dismissPressed() {
        displayPickerAs(open: false)
    }
    
}



protocol TableModel {
    
}






