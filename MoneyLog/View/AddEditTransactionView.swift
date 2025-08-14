//
//  AddTransactionView.swift
//  MoneyLog
//
//  Created by 박서인 on 8/13/25.
//

import SwiftUI
import SwiftData

struct AddEditTransactionView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var keyboardFocused: Bool
    
    let isAdding: Bool
    let transaction: Transaction?
    
    @State private var type: TransactionType
    @State private var amount: Int?
    @State private var enableDate: Bool
    @State private var date: Date
    @State private var note: String
    
    init() {
        isAdding = true
        transaction = nil
        
        type = .income
        amount = nil
        enableDate = true
        date = Date.now
        note = ""
    }
    
    init(transaction: Transaction) {
        isAdding = false
        self.transaction = transaction
        
        type = transaction.type
        amount = transaction.amount
        enableDate = transaction.date != nil
        date = transaction.date ?? Date.now
        note = transaction.note ?? ""
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
                            calendarImage
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
                        .focused($keyboardFocused)
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
                    titleText
                        .font(.title3)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add or Edit Transaction", systemImage: "checkmark") {
                        addEditTransform()
                        dismiss()
                    }
                    .disabled(!canAdd)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
    
    private var titleText: Text {
        isAdding ? Text("항목 추가") : Text("항목 수정")
    }
    
    private var calendarText: String {
        return type == .income ? "입금일" : "출금일"
    }
    
    private var calendarImage: Image {
        let calendar = Calendar.current
        let day = String(calendar.component(.day, from: date))
        let imageName = day + ".calendar"
        return Image(systemName: imageName)
    }
    
    private var color: Color {
        return type == .income ? .red : .blue
    }
    
    private var canAdd: Bool {
        return amount != nil
    }
    
    private func addEditTransform() {
        let newDate = enableDate ? date : nil
        let newNote = note == "" ? nil : note
        
        if isAdding {
            let transaction = Transaction(date: newDate, type: type, amount: amount!, note: newNote)
            modelContext.insert(transaction)
        } else {
            transaction!.type = type
            transaction!.amount = amount!
            transaction!.date = newDate
            transaction!.note = newNote
        }
    }
}

#Preview {
    AddEditTransactionView(transaction: Transaction(date: Date.now, type: .income, amount: 12000))
}
