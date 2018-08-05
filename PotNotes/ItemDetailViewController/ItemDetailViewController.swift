//
//  ItemDetailViewController.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 25/03/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//


import UIKit
import RealmSwift
import RxSwift
import SnapKit

class ItemDetailViewController: UIViewController {
    
    var viewModel: ItemDetailViewModel
    let bag = DisposeBag()
    var tableView = UITableView()
    
    lazy var photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = self.view.frame.size.width * 0.8
        layout.itemSize = CGSize(width: width, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
//        let inset = self.view.frame.size.width * 0.1
//        layout.sectionInset =  UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        let colleciton = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        var insets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
//        colleciton.contentInset = insets
        colleciton.backgroundColor = UIColor.background.light
        colleciton.showsHorizontalScrollIndicator = false
        return colleciton
    }()
    
    init(itemDetailViewMode: ItemDetailViewModel) {
        self.viewModel = itemDetailViewMode
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
        super.viewDidLoad()
        setupTable()
        setupPhotoCollection()
    }
    
    /// Centers collection view cells
    /// Scrolls to a central position to allow the collection view to act as a carousel
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let collectionViewInsets = self.view.frame.size.width * 0.1
        var insets = self.photoCollection.contentInset
        insets.left = collectionViewInsets
        insets.right = collectionViewInsets
        self.photoCollection.contentInset = insets
        self.photoCollection.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    func setupTable() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.register(SplitLabelCell.self, forCellReuseIdentifier: SplitLabelCell.id)
        tableView.backgroundColor = UIColor.background.light
        tableView.tableFooterView = UIView()

        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let headerView = UIView()
        tableView.tableHeaderView = headerView
        headerView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.width.equalToSuperview()
        }
        
        headerView.addSubview(photoCollection)
        photoCollection.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        viewModel.potteryItem
            .map{[$0]}
            .bind(to: tableView.rx.items(cellIdentifier: SplitLabelCell.id, cellType: SplitLabelCell.self)) { row, model, cell in
                cell.potteryItem = model
            }
            .disposed(by: bag)
        
    }
    
    func setupPhotoCollection() {
        photoCollection.delegate = self
        photoCollection.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
        
        viewModel.imagePaths
            .bind(to: photoCollection.rx.items(cellIdentifier: PhotoCollectionViewCell.id, cellType: PhotoCollectionViewCell.self)) { row, model, cell in
                cell.path = model
            }
            .disposed(by: bag)
        
        photoCollection.rx.modelSelected(String?.self)
            .filter({ $0 == nil })
            .subscribe(onNext: { (_) in
                self.selectImage()
            })
            .disposed(by: bag)
    }
    
    func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)

    }
    
}

// MARK: - Collection View Delegate Flow Layout
extension ItemDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.8, height: 200);
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        let possibleSwitch = topThreeSwitches[indexPath.row  % topThreeSwitches.count]
//        handleTap(possibleSwitch)
//    }
}

extension ItemDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            viewModel.add(image: pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

struct ItemDetailViewModel {
    
    let potteryItemUuid: String
    let bag = DisposeBag()
    var potteryItem: Observable<PotteryItem>

    init(potteryItemUuid: String) {
        self.potteryItemUuid = potteryItemUuid
        potteryItem = PotteryItem.obseravble
                .map{ $0.first(where: { $0.uuid == potteryItemUuid })}
                .map{ $0! }
                .share(replay: 1)
    }
    
    var imagePaths: Observable<[String?]> {
        return potteryItem
            .map{ $0.images }
            .debounce(0.2, scheduler: MainScheduler.instance)
            .map{ $0.map{ $0.path }}
            .map { (paths) -> [String?] in
                var all: [String?] = paths
                all.append(nil)
                return all
        }
    }
    
    func add(image: UIImage) {
        potteryItem
            .take(1)
            .map { (item) -> PotteryItem in
                let imageContainer = ImageContainer(image: image)
                item.images.append(imageContainer!)
                item.created = Date()
                return item
            }
            .flatMap({ (item) -> Observable<PotteryItem> in
                return item.save()
            })
            .subscribe()
            .disposed(by: bag)
        
    }
}

