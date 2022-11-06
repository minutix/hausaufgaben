//
//  ContentView.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Homework.lesson, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Homework>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Homework")
                    .font(.largeTitle)
                    .bold()
                List {
                    ForEach(items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.lesson ?? "item.lesson")
                                HStack {
                                    Text("\(item.text ?? "item.text") \(item.dueDate != nil ? "—" : "" ) \(item.dueDate?.formatted(date: .numeric, time: .omitted) ?? "")")
                                }
                            }
                            Spacer()
                            Button {
                                items[items.firstIndex(of: item)!].isDone.toggle()
                            } label: {
                                Image(systemName: "checkmark.circle\(item.isDone ? ".fill" : "")")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        NavigationLink {
                            AddView()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }.navigationTitle(Text("Homework"))
    }

    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
