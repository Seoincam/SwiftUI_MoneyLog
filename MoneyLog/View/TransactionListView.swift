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
                ForEach(transactions) { item in
                    TransactionRowView(transaction: item)
                }
            }
        }
    }

#Preview {
    TransactionListView()
}
