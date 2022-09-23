//
//  TestModel.swift
//  BankAppRealmDB
//
//  Created by Ruslan Ismailov on 23/09/22.
//

import Foundation
import RealmSwift



class Model {
    //realm
    let realm = try! Realm()
    var item: BancCard? = nil
    var items: Results<BancCard>? = nil
    //
    
    func sumRealm () -> Float {
        items = realm.objects(BancCard.self)
        
        var amount: Float = 0.0
        
        for i in items!{
            amount += i.amount
        }
        return amount
    }
}
