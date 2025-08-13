//
//  TransactionRowView.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            VStack {
                Text("🌭")
                    .font(.title2)
                    .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading) {
                transaction.type == .income
                ? Text("+ \(transaction.amount, format: .currency(code: "KRW"))")
                    .foregroundStyle(color)
                    .font(.title3)
                : Text("- \(transaction.amount, format: .currency(code: "KRW"))")
                    .foregroundStyle(color)
                    .font(.title3)
                
                Text(note)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    
    private var color: Color {
        transaction.type == .income ? .red : .blue
    }
    
    private var note: String {
        transaction.note != nil ? transaction.note! : "식비"
    }
}

#Preview {
    List {
        TransactionRowView(transaction: Transaction(date: Date.now, type: .expense, amount: 18000, note: "대면 작업 룸 & 밥"))
        TransactionRowView(transaction: Transaction(date: Date.now, type: .income, amount: 18000, note: nil))
    }
}
