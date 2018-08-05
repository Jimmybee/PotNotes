//
//  PotteryType.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 28/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import Foundation
import RxSwift

struct PotteryType: ListSelection {
    
    var uuid: String?
    var title: String?
    
    init(title: String) {
        self.uuid = UUID().uuidString
        self.title = title
    }
    
    init(_ type: PotteryTypeRealm) {
        self.uuid = type.uuid
        self.title = type.title
    }
    
    func convertToRealm() -> PotteryTypeRealm {
        return PotteryTypeRealm(self)
    }
    
    func save() -> Observable<PotteryType>{
        return PotteryTypeRealm(self).save().map({PotteryType($0)})
    }
    
   static var obseravble: Observable<[PotteryType]> {
        return PotteryTypeRealm.observable
            .map { (result) -> [PotteryType] in
                return result.flatMap { PotteryType($0)}
            }
            .share(replay: 1)
    }
    
    
}

