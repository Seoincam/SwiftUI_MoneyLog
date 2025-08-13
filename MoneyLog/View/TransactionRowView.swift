//
//  TransactionRowView.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    
    private var amount: Int {
        return transaction.type == .income ? transaction.amount : transaction.amount * -1
    }
    
    private var color: Color {
        return transaction.type == .income ? .red : .blue
    }
    
    private var note: String {
        return transaction.note != nil ? transaction.note! : "식비"
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("🌭")
                    .font(.title)
                    .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading) {
                Text(amount, format: .currency(code: "KRW"))
                    .foregroundStyle(color)
                    .font(.title3)
                
                Text(note)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    List {
        TransactionRowView(transaction: Transaction(date: Date.now, type: .expense, amount: 18000, note: "대면 작업 룸 & 밥"))
        TransactionRowView(transaction: Transaction(date: Date.now, type: .expense, amount: 18000, note: nil))
    }
}
