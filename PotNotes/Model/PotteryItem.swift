//
//  PotteryItem.swift
//  PotNotes
//
//  Created by James Birtwell on 21/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit

class PotteryItem {
    
    var name: String?
    var created: Date?
    var sellPrice: Double?
//    var type: PotteryType?
//    var glase: Glaze?
    var completed: Bool
    var images: [UIImage]? = []
    var height: Double?
    var width: Double?
    var weight: Double?
    
    init() {
        self.completed = false
    }
    
    init(_ potteryItem: PotteryItemRealm) {
        self.name = potteryItem.name
        self.created = potteryItem.created
        self.sellPrice = potteryItem.sellPrice.value
//        self.type = potteryItem.type.flatMap({PotteryType(rawValue: $0)})
//        self.glase = potteryItem.glase.flatMap({Glaze(rawValue: $0)})
        self.completed = potteryItem.completed
        self.images =  potteryItem.images?.flatMap({ UIImage(data: $0) })
        self.height = potteryItem.height.value
        self.width = potteryItem.width.value
        self.weight = potteryItem.weight.value
    }
}

struct PotteryType: ListSelection {
    var title: String
    var id: Int
}


enum Glaze: String {
    case tonks, sonks
}


