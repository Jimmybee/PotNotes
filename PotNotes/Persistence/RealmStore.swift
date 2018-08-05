//
//  RealmStore.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 28/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

// MARK: Application/View state
extension Realm {
    
    var potteryItems: Results<PotteryItemRealm> {
        return objects(PotteryItemRealm.self)
    }

    var potteryTypes: Results<PotteryTypeRealm> {
        return objects(PotteryTypeRealm.self)
    }
    
}

// MARK: Actions
extension Realm {
    
    func saveAll<T: Object>(objects: [T]) -> Observable<Void> {
        do {
            beginWrite()
            objects.forEach{ add($0, update: true) }
            try commitWrite()
            return Observable.of(())
        } catch {
            return Observable.error(DataStoreError.failedSave)
        }
    }
    
    func save<T: Object>(object: T) -> Observable<T> {
        do {
            beginWrite()
            add(object, update: true)
            try commitWrite()
            return Observable.of(object)
        } catch {
            return Observable.error(DataStoreError.failedSave)
        }
    }
    
}

enum DataStoreError: Error {
    case failedSave
}
