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
    
    var body: some View {
        NavigationStack {
            TransactionListView()
                .navigationTitle("25년 08월")
                .toolbar {
                    ToolbarItem {
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
        .modelContainer(for: Transaction.self, inMemory: true)
}
