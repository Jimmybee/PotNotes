//
//  PotteryItem.swift
//  PotNotes
//
//  Created by James Birtwell on 21/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import RxSwift

class PotteryItem {
    
    var uuid: String?
    var name: String?
    var created: Date?
    var sellPrice: Double?
    var type: PotteryType?
    //    var glase: Glaze?
    var completed: Bool
    var images = [ImageContainer]()
    var height: Double?
    var width: Double?
    var weight: Double?
    
    init() {
        self.uuid = UUID().uuidString
        self.completed = false
    }
    
    init(_ potteryItem: PotteryItemRealm) {
        self.uuid = potteryItem.uuid
        self.name = potteryItem.name
        self.created = potteryItem.created
//        self.sellPrice = potteryItem.sellPrice.value
        self.type = potteryItem.type.flatMap({PotteryType($0)})
//        self.glase = potteryItem.glase.flatMap({Glaze(rawValue: $0)})
        self.completed = potteryItem.completed
        self.images =  potteryItem.imagePaths.map{ ImageContainer(path: $0.string) }
//        self.height = potteryItem.height.value
//        self.width = potteryItem.width.value
//        self.weight = potteryItem.weight.value
    }
    
    static var obseravble: Observable<[PotteryItem]> {
        return PotteryItemRealm.observable
            .map { (result) -> [PotteryItem] in
                return result.flatMap { PotteryItem($0)}
            }
            .share(replay: 1)
    }
    
    func save() -> Observable<PotteryItem>{
        return PotteryItemRealm(self).save().map({PotteryItem($0)})
    }
    
    func update(name: String) -> PotteryItem {
        self.name = name
        return self
    }
    
    func update(potteryType: PotteryType) -> PotteryItem {
        self.type = potteryType
        return self
    }
}


enum Glaze: String {
    case tonks, sonks
}


