//
//  TransactionList.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import SwiftUI
import SwiftData

struct TransactionListView: View {
    @Environment(\.calendar) private var calendar
    @Query private var transactions: [Transaction]
    
    var body: some View {
        List {
            if !undated.isEmpty {
                Section(header: Text("날짜 없음")) {
                    ForEach(undated) { item in
                        TransactionRowView(transaction: item)
                    }
                }
                
            }
            
            ForEach(sortedDays, id: \.self) { day in
                Section(header: Text(sectionTitle(for: day))) {
                    ForEach (datedDict[day] ?? []) { item in
                        TransactionRowView(transaction: item)
                    }
                }
            }
        }
    }
    
    // MARK: - 정렬 도우미
    
    private var datedPairs: [(Date, Transaction)] {
        transactions.compactMap { t in
            guard let d = t.date else { return nil }
            return (calendar.startOfDay(for: d), t)
        }
    }
    
    private var datedDict: [Date: [Transaction]] {
        Dictionary(grouping: datedPairs, by: { $0.0 })
            .mapValues { $0.map(\.1) }
    }
    
    // 섹션 헤더가 될 날짜들 (최신이 위로)
    private var sortedDays: [Date] {
        datedDict.keys.sorted(by: >)
    }
    
    private var undated: [Transaction] {
        transactions.filter { $0.date == nil }
    }
    
    // 섹션 타이틀 (한국어 요일까지)
    private func sectionTitle(for day: Date) -> String {
        day.formatted(
            Date.FormatStyle()
                .locale(Locale(identifier: "ko"))
                .month().day().weekday(.wide)
        )
    }
    
    }

#Preview {
    TransactionListView()
        .modelContainer(PreviewContainer.shared.container)
}
