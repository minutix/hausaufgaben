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
                TextField(String(localized: "LABEL.ADD_SHEET.LESSON", comment: "The label for the Lesson text field in the AddView"), text: $lesson)
                TextField(String(localized: "LABEL.ADD_SHEET.TASK", comment: "The label for the Task text field in the AddView"), text: $text)
                Toggle(String(localized: "LABEL.ADD_SHEET.TOGGLE_DUE_DATE", comment: "The label for the \"Has Due Date\" toggle in the AddView"), isOn: $hasDueDate)
                if hasDueDate {
                    DatePicker(selection: $dueDate, displayedComponents: [.date], label: {Text("LABEL.ADD_SHEET.DUE_DATE", comment: "The label for the Due Date picker in the AddView")})
                }
                #if os(watchOS)
                VStack {
                    Text("LABEL.ADD_SHEET.DIFFICULTY", comment: "The label for the Difficulty stepper in the AddView (on watchOS)")
                    Stepper("\(difficulty)", value: $difficulty, in: 0...5)
                }
                #else
                Stepper(value: $difficulty, in: 0...5) {
                    Text("LABEL.ADD_SHEET.DIFFICULTY \(difficulty)", comment: "The label for the Difficulty stepper in the AddView (except watchOS), with `%lld` being the difficulty")
                }
                #endif
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(String(localized: "BUTTON.ADD_SHEET.CANCEL", comment: "The Cancel button to dismiss the AddView sheet"), role: .cancel) {
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
                        Text("BUTTON.ADD_SHEET.DONE", comment: "The Done button for the AddView to dismiss the sheet and push the new task.")
                    }
                    .alert(String(localized: "ERROR.ADD_SHEET.EMPTY", comment: "The error in the AddView that prevents the user from adding a task with empty text"), isPresented: $alertPresented, actions: {Button(action: {alertPresented = false}, label: {Text("BUTTON.ADD_SHEET.ERROR.EMPTY.OK", comment: "The button to dismiss the AddView empty text field error (most likely something like \"OK\", \"Dismiss\" or similar)")})})
                }
            }
            #if os(macOS)
            .padding()
            #endif
        }
        .navigationTitle(String(localized: "STRING.ADD_SHEET.TITLE", comment: "The title for the AddView sheet. Empty on watchOS"))
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

