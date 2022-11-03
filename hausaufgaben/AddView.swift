//
//  AddView.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
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
            let newItem = Homework(context: viewContext)
            newItem.text = text
            newItem.lesson = lesson
            newItem.dueDate = hasDueDate ? dueDate : nil
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
