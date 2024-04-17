//
//  AddView.swift
//  hausaufgaben Watch App
//
//  Created by Linus Warnatz on 12.10.23.
//

import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var alertPresented = false
    @State var text = ""
    @State var lesson = ""
    @State var hasDueDate = true
    @State var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @State var difficulty = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(String(localized: "LESSON"), text: $lesson)
                TextField(String(localized: "TASK"), text: $text)
                Toggle(String(localized: "HAS_DUE_DATE", comment: "The label for the \"Has Due Date\" toggle in the AddView"), isOn: $hasDueDate)
                if hasDueDate {
                    DatePicker(selection: $dueDate, displayedComponents: [.date], label: {Text("DUE_DATE", comment: "The label for the Due Date picker in the AddView")})
                }
                #if os(watchOS)
                VStack {
                    Text("DIFFICULTY", comment: "The label for the Difficulty stepper in the AddView (on watchOS)")
                    Stepper(String(difficulty), value: $difficulty, in: 0...5)
                }
                #else
                Stepper(value: $difficulty, in: 0...5) {
                    Text("DIFFICULTY \(difficulty)", comment: "The label for the Difficulty stepper in the AddView (except watchOS), with `%lld` being the difficulty")
                }
                #endif
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(String(localized: "CANCEL", comment: "A Cancel button to dismiss a sheet"), role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if lesson != "" || text != "" {
                            addItem()
                            dismiss()
                        } else {
                            alertPresented = true
                        }
                    } label: {
                        Text("DONE", comment: "A Done button to dismiss a sheet, saving changes")
                    }
                    .alert(
                        String(
                            localized: "ERROR_TEXT_FIELDS_EMPTY",
                            comment: "The error in the AddView that prevents the user from adding a task with empty text"
                        ),
                        isPresented: $alertPresented,
                        actions: {
                            Button(
                                action: {
                                    alertPresented = false
                                },
                                label: {
                                    Text("OK")
                                }
                            )
                        }
                    )
                }
            }
            #if os(macOS)
            .padding()
            #endif
        }
        #if os(watchOS)
        .navigationTitle(String(localized: "ADD_SHEET_TITLE", comment: "The title for the AddView sheet. Empty on watchOS"))
        #endif
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Homework(difficulty: difficulty, dueDate: dueDate, lesson: lesson, text: text)
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    AddView()
        .modelContainer(for: Homework.self, inMemory: true)
}

