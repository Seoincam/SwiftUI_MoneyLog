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
            Text(transaction.category.symbol)
                .font(.title2)
                .padding(.trailing, 8)
            
            amountText
                .foregroundStyle(color)
                .font(.title3)
            
            note
                .font(.callout)
        }
        .contentShape(Rectangle())
    }
    
    
    private var color: Color {
        transaction.type == .income ? .red : .blue
    }
    
    private var note: Text {
        transaction.note != nil
        ? Text(transaction.note!)
            .foregroundStyle(.black)

        : Text(transaction.category.name)
            .foregroundStyle(.gray)

    }
    
    private var amountText: Text {
        let sign = transaction.type == .income ? "+" : "-"
        return Text("\(sign)\(transaction.amount, format: WonStyleInt())")
    }
}

#Preview {
    List {
        TransactionRowView(transaction: Transaction(date: Date.now, type: .expense, amount: 18000, note: "대면 작업 룸 & 밥", category: Category(symbol: "😶", name: "기타 지출", type: .expense)))
        TransactionRowView(transaction: Transaction(date: Date.now, type: .income, amount: 600000, note: nil, category: Category(symbol: "💵", name: "용돈", type: .income)))
    }
}
