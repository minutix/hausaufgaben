//
//  AddView.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var entries: Entries
    @State var text = ""
    @State var lesson = ""
    @State var hasDueDate = true
    @State var dueDate = Date()
    
    var body: some View {
        VStack {
            TextField("Homework Entry Text", text: $text)
            TextField("Lesson", text: $lesson)
            Toggle("Has Due Date", isOn: $hasDueDate)
            if hasDueDate {
                DatePicker(selection: $dueDate, displayedComponents: [.date], label: {Text("Due Date")})
            }
            Spacer()
        }
        .navigationTitle("Add Item")
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    addItem()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                }
            }
        }
    }
    
    func addItem() {
        withAnimation {
            entries.listContent.append(Homework(lesson: lesson, text: text, dueDate: hasDueDate ? dueDate : nil))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(Entries())
    }
}
