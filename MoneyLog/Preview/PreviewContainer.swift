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

        // MARK: - 카테고리 정의 및 삽입
        let foodCategory = Category(symbol: "🍔", name: "식비", type: .expense)
        let cafeCategory = Category(symbol: "☕️", name: "카페", type: .expense)
        let transportCategory = Category(symbol: "🚌", name: "교통", type: .expense)
        let giftCategory = Category(symbol: "🎁", name: "선물", type: .expense)
        let shoppingCategory = Category(symbol: "🛍️", name: "쇼핑", type: .expense)
        let dateCategory = Category(symbol: "💑", name: "데이트", type: .expense)
        let movieCategory = Category(symbol: "🎬", name: "문화생활", type: .expense)
        let jobCategory = Category(symbol: "💵", name: "아르바이트", type: .income)
        let tutoringCategory = Category(symbol: "📘", name: "과외", type: .income)
        let allowanceCategory = Category(symbol: "🧧", name: "용돈", type: .income)
        let tradeCategory = Category(symbol: "💻", name: "중고 거래", type: .income)
        let otherCategory = Category(symbol: "😶", name: "기타 지출", type: .expense)

        let categories = [
            foodCategory, cafeCategory, transportCategory, giftCategory,
            shoppingCategory, dateCategory, movieCategory, jobCategory,
            tutoringCategory, allowanceCategory, tradeCategory, otherCategory
        ]

        for category in categories {
            container.mainContext.insert(category)
        }
        
        try? container.mainContext.save()

        // MARK: - 날짜 생성 헬퍼 함수
        func makeDate(_ day: Int) -> Date {
            return calendar.date(from: DateComponents(year: 2025, month: 8, day: day))!
        }

        // MARK: - 거래 더미 데이터
        let transactionsSeed: [(day: Int, type: TransactionType, amount: Int, note: String?, category: Category)] = [
            (1,  .income,  300000, "아르바이트 급여",     jobCategory),
            (2,  .expense, 12000,  "카페 - 아이스라떼",    cafeCategory),
            (3,  .expense, 20000,  nil,           foodCategory),
            (4,  .expense, 52000,  "문구류 쇼핑",         shoppingCategory),
            (5,  .income,  150000, "과외비 입금",         tutoringCategory),
            (6,  .expense, 7800,   "버스 교통비",         transportCategory),
            (7,  .expense, 31000,  nil,      giftCategory),
            (8,  .income,  50000,  "중고 거래",           tradeCategory),
            (9,  .expense, 8900,   "편의점 간식",         foodCategory),
            (10, .expense, 44000,  "데이트 식사",         dateCategory),
            (11, .expense, 13200,  "택시비",              transportCategory),
            (12, .expense, 24000,  nil,            movieCategory),
            (13, .income,  100000, "용돈",                allowanceCategory),
            (14, .expense, 38000,  "쇼핑몰",              shoppingCategory),
            (15, .expense, 18000,  "대면 작업 룸 & 밥",   otherCategory)
        ]

        for seed in transactionsSeed {
            let date = makeDate(seed.day)
            let transaction = Transaction(date: date,
                                          type: seed.type,
                                          amount: seed.amount,
                                          note: seed.note,
                                          category: seed.category, createdAt: date)
            container.mainContext.insert(transaction)
        }

        try? container.mainContext.save()
    }
}
