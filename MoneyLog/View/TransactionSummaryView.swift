//
//  TransactionSummaryView.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import SwiftUI
import SwiftData

struct TransactionSummaryView: View {
    @Query private var transactions: [Transaction]

    var body: some View {
        Form {
            Section("총괄") {
                HStack {
                    Image(systemName: "wallet.bifold")
                    Text("잔액")
                    Spacer()
                    Text("+ \(total, format: .currency(code: "KRW"))")
                        .foregroundStyle(color(amount: total))
                }
                .font(.title3)
            }
            .headerProminence(.increased)
            
            Section {
                HStack {
                    Image(systemName: "banknote")
                    Text("수익 총괄")
                        .foregroundStyle(.gray)
                    Spacer()
                    Text("+ \(incomeTotal, format: .currency(code: "KRW"))")
                        .foregroundStyle(.red)
                }
                .font(.callout)
                
                HStack {
                    Image(systemName: "creditcard")
                    Text("지출 총괄")
                        .foregroundStyle(.gray)
                    Spacer()
                    Text("- \(expenseTotal, format: .currency(code: "KRW"))")
                        .foregroundStyle(.blue)
                }
                .font(.callout)
            }
        }

        
    }
    
    private var total: Int {
        transactions.reduce(0) { $0 + ($1.type == .income ? $1.amount : $1.amount * -1) }
    }
    
    private var incomeTotal: Int {
        transactions.filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
    }
    
    private var expenseTotal: Int {
        transactions.filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    
    private func color(amount: Int) -> Color {
        amount >= 0 ? .red : .blue
    }
}

#Preview {
    TransactionSummaryView()
        .modelContainer(PreviewContainer.shared.container)
}
