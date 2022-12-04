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
    @State private var alertPresented = false
    @State var text = ""
    @State var lesson = ""
    @State var hasDueDate = true
    @State var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @State var difficulty = 0
    
    var body: some View {
        VStack {
            TextField(String(localized: "Lesson"), text: $lesson)
            TextField(String(localized: "HET"), text: $text)
            Toggle(String(localized: "Has Due Date"), isOn: $hasDueDate)
            if hasDueDate {
                DatePicker(selection: $dueDate, displayedComponents: [.date], label: {Text(String(localized: "Due Date"))})
            }
            HStack() {
                Text("Difficulty Rating")
                
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
        .navigationTitle(String(localized: "Add Item"))
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if lesson != "" && text != "" {
                        addItem()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        alertPresented = true
                    }
                    
                } label: {
                    Text("Done")
                }
                .alert("Text fields cannot be empty", isPresented: $alertPresented, actions: {Button(action: {alertPresented = false}, label: {Text("OK")})})
            }
        }
    }
    
    func addItem() {
        withAnimation {
            let newItem = Homework(context: viewContext)
            newItem.text = text
            newItem.lesson = lesson
            newItem.dueDate = hasDueDate ? dueDate : nil
            newItem.difficulty = Int16(difficulty)
            
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
