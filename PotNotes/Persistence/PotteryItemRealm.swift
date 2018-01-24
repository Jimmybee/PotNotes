//
//  PotteryItemRealm.swift
//  PotNotes
//
//  Created by James Birtwell on 21/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import RealmSwift

class PotteryItemRealm: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var created: Date?
    let sellPrice: RealmOptional<Double> = RealmOptional(nil)
    @objc dynamic var type: String?
    @objc dynamic var glase: String?
    @objc dynamic var completed = false
    @objc dynamic var images: [Data]?
    let height: RealmOptional<Double> = RealmOptional(nil)
    let width: RealmOptional<Double> = RealmOptional(nil)
    let weight: RealmOptional<Double> = RealmOptional(nil)
    
    convenience init(_ potteryItem: PotteryItem) {
        self.init()
        self.name = potteryItem.name
        self.created = potteryItem.created
        self.sellPrice.value = potteryItem.sellPrice
//        self.type = potteryItem.type?.rawValue
//        self.glase = potteryItem.glase?.rawValue
        self.completed = potteryItem.completed
        self.images =  potteryItem.images?.flatMap({ UIImageJPEGRepresentation($0, 0.5) })
        self.height.value = potteryItem.height
        self.width.value = potteryItem.width
        self.weight.value = potteryItem.weight
    }
}
