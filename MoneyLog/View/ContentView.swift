//
//  ContentView.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddTransaction: Bool = false
    
    @State private var type: TransactionType = .expense
    
    var body: some View {
        NavigationStack {
            TransactionListView()
                .navigationTitle("25년 08월")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Item", systemImage: "plus") {
                            showingAddTransaction = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        .sheet(isPresented: $showingAddTransaction) {
            AddTransactionView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.shared.container)
}
