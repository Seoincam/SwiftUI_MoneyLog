//
//  Category.swift
//  MoneyLog
//
//  Created by 박서인 on 8/14/25.
//

import Foundation
import SwiftData

@Model
final class Category {
    var emoji: String
    var name: String
    
    @Relationship(deleteRule: .nullify)
    var transactions: [Transaction] = []
    
    init(emoji: String, name: String) {
        self.emoji = emoji
        self.name = name
    }
}
