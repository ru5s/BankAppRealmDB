//
//  ModelRealm.swift
//  BankAppRealmDB
//
//  Created by Ruslan Ismailov on 23/09/22.
//

import Foundation
import RealmSwift

class BancCard: Object {
    @objc dynamic var name: String = "Test card"
    @objc dynamic var idCard: String = "Test test test test"
    @objc dynamic var amount: Float = 123.50
}

class AllCards: Object {
    var cards = List<BancCard>()
    var transfers = List<Transfer>()
}

class Transfer: Object {
    @objc dynamic var name: String = "Test card"
    @objc dynamic var idCard: String = "Test test test test"
    @objc dynamic var action: String = "Test action"
    @objc dynamic var finishAmount: Float = 123.50
    @objc dynamic var date: Date = Date()
}

