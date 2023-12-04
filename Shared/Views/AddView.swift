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
                TextField("LABEL.ADD_SHEET.LESSON", text: $lesson)
                TextField("LABEL.ADD_SHEET.TASK", text: $text)
                Toggle(String(localized: "LABEL.ADD_SHEET.TOGGLE_DUE_DATE"), isOn: $hasDueDate)
                if hasDueDate {
                    DatePicker(selection: $dueDate, displayedComponents: [.date], label: {Text("LABEL.ADD_SHEET.DUE_DATE")})
                }
                VStack {
                    Text("LABEL.ADD_SHEET.DIFFICULTY")
                    #if os(watchOS)
                    Stepper("\(difficulty)", value: $difficulty, in: 1...5)
                    #else
                    Stepper(value: $difficulty, in: 1...5, label: {StarView(difficulty: difficulty)})
                    #endif
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("BUTTON.ADD_SHEET.CANCEL", role: .cancel) {
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
                        Text("BUTTON.ADD_SHEET.DONE")
                    }
                        .alert("ERROR.ADD_SHEET.EMPTY", isPresented: $alertPresented, actions: {Button(action: {alertPresented = false}, label: {Text("BUTTON.ADD_SHEET.ERROR.EMPTY.OK")})})
                }
            }
        }
        .navigationTitle("STRING.ADD_SHEET.TITLE")
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Homework(difficulty: difficulty, dueDate: dueDate, lesson: lesson, text: text)
            modelContext.insert(newItem)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
