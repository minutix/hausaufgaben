//
//  AddView.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
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
                TextField("STRING.ADD_SHEET.LESSON", text: $lesson)
                TextField("STRING.ADD_SHEET.TASK", text: $text)
                Toggle(String(localized: "STRING.ADD_SHEET.TOGGLE_DUE_DATE"), isOn: $hasDueDate)
                if hasDueDate {
                    DatePicker(selection: $dueDate, displayedComponents: [.date], label: {Text("STRING.ADD_SHEET.DUE_DATE")})
                }
                HStack() {
                    Text("STRING.ADD_SHEET.DIFFICULTY")
                    
                    Spacer()
                    
                    Button {
                        difficulty = 1
                    } label: {
                        if difficulty < 1 {
                            Image(systemName: "star")
                        } else {
                            Image(systemName: "star.fill")
                        }
                    }
                    
                    Button {
                        difficulty = 2
                    } label: {
                        if difficulty < 2 {
                            Image(systemName: "star")
                        } else {
                            Image(systemName: "star.fill")
                        }
                    }
                    
                    Button {
                        difficulty = 3
                    } label: {
                        if difficulty < 3 {
                            Image(systemName: "star")
                        } else {
                            Image(systemName: "star.fill")
                        }
                    }
                    
                    Button {
                        difficulty = 4
                    } label: {
                        if difficulty < 4 {
                            Image(systemName: "star")
                        } else {
                            Image(systemName: "star.fill")
                        }
                    }
                    
                    Button {
                        difficulty = 5
                    } label: {
                        if difficulty < 5 {
                            Image(systemName: "star")
                        } else {
                            Image(systemName: "star.fill")
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle(String(localized: "STRING.ADD_SHEET.TITLE"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("BUTTON.ADD_SHEET.CANCEL", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if lesson != "" && text != "" {
                            addItem()
                            dismiss()
                        } else {
                            alertPresented = true
                        }
                        
                    } label: {
                        Text("BUTTON.ADD_SHEET.DONE")
                    }
                        .alert("ERROR.ADD_SHEET.EMPTY", isPresented: $alertPresented, actions: {Button(action: {alertPresented = false}, label: {Text("OK")})})
                }
        }
        }
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
