//
//  ItemListViewController.swift
//  PotNotes
//
//  Created by James Birtwell on 21/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class ItemListViewController: UIViewController {
    
    let bag = DisposeBag()
    var tableView = UITableView()
    
    lazy var createButton: UIButton = {
        let bttn = UIButton()
        bttn.setImage(#imageLiteral(resourceName: "icn_cross"), for: .normal)
        bttn.backgroundColor = .darkGray
        bttn.setTitle(nil, for: .normal)
        bttn.addShadowWith(elevation: 6)
        bttn.layer.cornerRadius  = 40
        bttn.tintColor = .white
        return bttn
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setupDatabase()
        setupViewAndConstraints()
        setupCreateBttn()
        setupTable()
    }
    
    func setupViewAndConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        view.addSubview(createButton)
        createButton.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().inset(30)
            make.size.equalTo(80)
        }
    }
    
    private func setupCreateBttn() {
        createButton.rx.tap
            .subscribe(onNext: { [unowned self] (_) in
                let editItemViewController = EditItemViewController()
                self.navigationController?.pushViewController(editItemViewController, animated: true)
            })
            .disposed(by: bag)
    }
    
    private func setupTable() {

        tableView.register(PotteryItemTableViewCell.self, forCellReuseIdentifier: "test")
        tableView.backgroundColor = UIColor.background.light
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 200
        tableView.delegate = self
        
        PotteryItem.obseravble
            .bind(to: tableView.rx.items(cellIdentifier: "test", cellType: PotteryItemTableViewCell.self)) { row, model, cell in
                cell.potteryItem = model
            }
            .disposed(by: bag)
        
        
        tableView.rx.modelSelected(PotteryItem.self)
            .subscribe(onNext: { [unowned self] (selection) in
                let itemDetailViewModel = ItemDetailViewModel(potteryItemUuid: selection.uuid!)
                let idvc = ItemDetailViewController(itemDetailViewMode: itemDetailViewModel)
                self.navigationController?.pushViewController(idvc, animated: true)
            })
            .disposed(by: bag)
        
//        tableView.rx.modelSelected(PotteryItem.self)
//            .subscribe(onNext: { [unowned self] (selection) in
//                let editItemViewController = EditItemViewController(item: selection)
//                self.navigationController?.pushViewController(editItemViewController, animated: true)
//            })
//            .disposed(by: bag)
    }
    
    func setupDatabase() {
        let types = [PotteryType(title: "Bowl"), PotteryType(title: "Mug")]
        let realmtypes = types.map({ $0.convertToRealm() })
        let store = try! Realm()
        store.saveAll(objects: realmtypes).subscribe().disposed(by: bag)
    }
}

extension ItemListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


