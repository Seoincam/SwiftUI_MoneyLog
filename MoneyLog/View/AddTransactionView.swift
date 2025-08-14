//
//  AddTransactionView.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import SwiftUI
import SwiftData

struct AddTransactionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var keyboardFocused: Bool
    
    @State private var type: TransactionType = .income
    @State private var amount: Int? = nil
    @State private var enableDate = true
    @State private var date = Date.now
    @State private var note: String = ""
    
    private var calendarText: String {
        return type == .income ? "입금일" : "출금일"
    }
    
    private var color: Color {
        return type == .income ? .red : .blue
    }
    
    private var canAdd: Bool {
        return amount != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("종류", selection: $type) {
                        Text("입금").tag(TransactionType.income)
                        Text("출금").tag(TransactionType.expense)
                    }
                    
                    VStack {
                        TextField("금액", value: $amount, format: WonStyleInt())
                            .keyboardType(.numberPad)
                            .focused($keyboardFocused)
                            .font(.title)
                            .foregroundStyle(color)
                        }
                        .toolbar {
                            // FIXME: 간격 문제로 추후 수정해야함.
                            // safeAreaInset 찾아보기
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Check", systemImage: "checkmark") { keyboardFocused = false }
                                    .buttonStyle(.borderedProminent)
                            }
                        }
                }
                
                Section {
                    HStack {
                        Image(systemName: "calendar")
                            .font(.title3)
                            .foregroundStyle(.gray)
                            .padding(4)

                        Toggle("날짜", isOn: $enableDate)
                    }
                    
                    if enableDate {
                        HStack {
                            Image(systemName: "1.calendar")
                                .font(.title3)
                                .foregroundStyle(.gray)
                                .padding(4)
                            
                            DatePicker(calendarText, selection: $date, displayedComponents: [.date])
                                .datePickerStyle(.compact)
                                .environment(\.locale, Locale(identifier: "ko"))
                            
                            Text(date.formatted(
                                Date.FormatStyle()
                                    .locale(Locale(identifier: "ko"))
                                    .weekday(.wide)
                            ))
                            .font(.callout)
                            .foregroundStyle(.gray)
                        }
                    }
                }
                
                Section {
                    TextField("설명", text: $note)
                }
            }
            .animation(.default, value: enableDate)
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("추가하기")
                        .font(.title3)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Transaction", systemImage: "checkmark") {
                        addTransaction()
                        dismiss()
                    }
                    .disabled(!canAdd)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
    
    private func addTransaction() {
        let newDate = enableDate ? date : nil
        let newNote = note == "" ? nil : note
        let transaction = Transaction(date: newDate, type: type, amount: amount!, note: newNote)
        modelContext.insert(transaction)
    }
}

#Preview {
    AddTransactionView()
}
