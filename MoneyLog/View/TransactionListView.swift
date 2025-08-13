//
//  TransactionList.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import SwiftUI
import SwiftData

struct TransactionListView: View {
    @Query private var transactions: [Transaction]
    
    var body: some View {
        List {
            Section {
                ForEach(transactions) { item in
                    VStack {
                        Text(item.createdAt, format: Date.FormatStyle(date: .omitted, time: .complete))
                        Text(item.amount, format: .currency(code: "krw"))
                    }
                }
            }
        }

    }
}

#Preview {
    TransactionListView()
}
