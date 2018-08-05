//
//  PotteryTypeRealm.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 28/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

class PotteryTypeRealm: Object {
    
    @objc dynamic var uuid: String?
    @objc dynamic var title: String?
    
    convenience init(_ type: PotteryType) {
        self.init()
        self.uuid = type.uuid
        self.title = type.title
    }
    
    static var observable: Observable<Results<PotteryTypeRealm>> {
        let store = try! Realm()
        return Observable.collection(from: store.potteryTypes)
    }
    
    func save() -> Observable<PotteryTypeRealm> {
        let store = try! Realm()
        return store.save(object: self)
    }
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
