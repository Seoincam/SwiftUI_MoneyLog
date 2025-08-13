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
    @State private var showingSummary = true
    
    var body: some View {
        NavigationStack {
            Group {
                if showingSummary {
                    TransactionSummaryView()
                } else {
                    TransactionListView()
                }
            }
                .navigationTitle("2025년 08월")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Picker("종류", selection: $showingSummary) {
                            Text("요약").tag(true)
                            Text("전체").tag(false)
                        }
                        .pickerStyle(.menu)
                        .labelsHidden()
                    }
                    
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
