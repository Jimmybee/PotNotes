//
//  PotteryItemRealm.swift
//  PotNotes
//
//  Created by James Birtwell on 21/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import Kingfisher

class PotteryItemRealm: Object {
    
    @objc dynamic var uuid: String?
    @objc dynamic var name: String?
    @objc dynamic var created: Date?
//    let sellPrice: RealmOptional<Double> = RealmOptional(nil)
    @objc dynamic var type: PotteryTypeRealm?
    @objc dynamic var glase: String?
    @objc dynamic var completed = false
    var imagePaths = List<RealmString>()
//    let height: RealmOptional<Double> = RealmOptional(nil)
//    let width: RealmOptional<Double> = RealmOptional(nil)
//    let weight: RealmOptional<Double> = RealmOptional(nil)
    
    convenience init(_ potteryItem: PotteryItem) {
        self.init()
        self.uuid = potteryItem.uuid
        self.name = potteryItem.name
        self.created = potteryItem.created
//        self.sellPrice.value = potteryItem.sellPrice
        self.type = potteryItem.type?.convertToRealm()
//        self.glase = potteryItem.glase?.rawValue
        self.completed = potteryItem.completed
        potteryItem.images.map({ $0.asRealmString} ).forEach { imagePaths.append($0) }
//        self.height.value = potteryItem.height
//        self.width.value = potteryItem.width
//        self.weight.value = potteryItem.weight
    }
    
    func save() -> Observable<PotteryItemRealm> {
        let store = try! Realm()
        return store.save(object: self)
    }
    
    static var observable: Observable<Results<PotteryItemRealm>> {
        let store = try! Realm()
        return Observable.collection(from: store.potteryItems)
    }
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}

class RealmString: Object {
    @objc dynamic var string: String = ""

    convenience init(_ string: String) {
        self.init()
        self.string = string
    }
}

struct ImageContainer {
    
    var path: String
    
    init(path: String) {
        self.path = path
    }
    
    init?(image: UIImage) {
        path = UUID().uuidString
        ImageCache.default.store(image, forKey: path)
//        if let data = UIImagePNGRepresentation(image) {
//            let unqiuePath = UUID().uuidString
//            let filename = FileManager.getDocumentsDirectory().appendingPathComponent(unqiuePath)
//            try! data.write(to: filename)
//            self.path = filename.absoluteString
//        } else {
//            return nil
//        }
    }
    
    func getImage() -> UIImage? {
        return ImageCache.default.retrieveImageInDiskCache(forKey: path)
//        let fileManager = FileManager.default
//        if fileManager.fileExists(atPath: path){
//            return UIImage(contentsOfFile: path)
//        }else{
//            return nil
//        }
    }
    
    var asRealmString: RealmString {
        return RealmString(path)
    }

}

extension FileManager {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

