//
//  Transaction.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import Foundation
import SwiftData


@Model
final class Transaction {
    var date: Date?
    var type: TransactionType
    var amount: Int
    var note: String?
    var createdAt: Date
    
    init(date: Date?,
         type:TransactionType,
         amount: Int,
         note: String? = nil,
         createdAt: Date = Date.now) {
        self.date = date
        self.type = type
        self.amount = amount
        self.note = note
        self.createdAt = createdAt
    }
}

enum TransactionType: String, Codable {
    case income
    case expense
}
