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
            Text("🌭")
                .font(.title2)
                .padding(.trailing, 8)
            
            amountText
                .foregroundStyle(color)
                .font(.title3)
            
            Text(note)
                .font(.callout)
                .foregroundStyle(.gray)
        }
        .onTapGesture {
            
        }
    }
    
    
    private var color: Color {
        transaction.type == .income ? .red : .blue
    }
    
    private var note: String {
        transaction.note != nil ? transaction.note! : "식비"
    }
    
    private var amountText: Text {
        let sign = transaction.type == .income ? "+" : "-"
        return Text("\(sign)\(transaction.amount, format: WonStyleInt())")
    }
}

#Preview {
    List {
        TransactionRowView(transaction: Transaction(date: Date.now, type: .expense, amount: 18000, note: "대면 작업 룸 & 밥"))
        TransactionRowView(transaction: Transaction(date: Date.now, type: .income, amount: 600000, note: nil))
    }
}
