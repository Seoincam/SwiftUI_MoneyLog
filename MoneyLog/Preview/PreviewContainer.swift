//
//  PreviewContainer.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import Foundation
import SwiftData

@MainActor
class  PreviewContainer {
    static let shared = PreviewContainer()
    
    let container: ModelContainer
    
    init() {
        let schema = Schema([
            Transaction.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema,
                                                            isStoredInMemoryOnly: true,
                                                            cloudKitDatabase: .none)
            
        do {
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertPreviewData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertPreviewData() {
        let calendar = Calendar.current
        let today = Date()

        // (date, type, amount, note, createdAt)
        let transactionsSeed: [(Date?, TransactionType, Int, String?, Date)] = [
            (today,                                     .expense,  12000,  "점심 식사",           calendar.date(byAdding: .day, value: -1, to: today) ?? today),
            (calendar.date(byAdding: .day, value: -3, to: today), .income,  250000, "과외비",               calendar.date(byAdding: .day, value: -3, to: today) ?? today),
            (calendar.date(byAdding: .day, value: -2, to: today), .expense, 48000,  "마트 장보기",         calendar.date(byAdding: .day, value: -2, to: today) ?? today),
            (today,                                     .expense,  2000,   "편의점",               today),
            (calendar.date(byAdding: .day, value: -10, to: today),.income,  1000000,"용돈",                 calendar.date(byAdding: .day, value: -9,  to: today) ?? today),
            (nil,                                       .expense,  5900,   "커피",                 calendar.date(byAdding: .day, value: -1,  to: today) ?? today),
            (calendar.date(byAdding: .day, value: -1, to: today), .expense, 45000,  "택시",                 calendar.date(byAdding: .day, value: -1,  to: today) ?? today),
            (calendar.date(byAdding: .day, value: -14, to: today),.income,  350000, "아르바이트 급여",     calendar.date(byAdding: .day, value: -14, to: today) ?? today),
            (calendar.date(byAdding: .day, value: -5, to: today), .expense, 72000,  "의류",                 calendar.date(byAdding: .day, value: -5,  to: today) ?? today),
            (calendar.date(byAdding: .day, value: -6, to: today), .expense, 120000, "식재료",               calendar.date(byAdding: .day, value: -6,  to: today) ?? today),
        ]
        
        for (date, type, amount, note, createdAt) in transactionsSeed {
            let transaction = Transaction(date: date, type: type, amount: amount, note: note, createdAt: createdAt)
            container.mainContext.insert(transaction)
            
        }
        try? container.mainContext.save()
    }
}
