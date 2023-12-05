//
//  HomeworkListView.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 11.10.23.
//

import SwiftUI
import SwiftData

struct HomeworkListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var editorPresented = false
    @Query(sort: \Homework.dueDate, order: .forward)
    var items: [Homework]
    
    private func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = items[index]
            modelContext.delete(item)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<items.count, id: \.self) { i in
                    ListItemView(item: items[i])
                        .padding()
                        .swipeActions(edge: .trailing) {
                            Button(action: {
                                items[i].isDone.toggle()
                            }, label:{
                                if items[i].isDone {
                                    Label(String(localized: "BUTTON.MARK_UNDONE", comment: "The \"Mark Undone\" slide action/button in the list or detail view, when the item is already done"), systemImage: "xmark.circle")
                                } else {
                                    Label(String(localized: "BUTTON.MARK_DONE", comment: "The \"Mark Undone\" slide action/button in the list or detail view, when the item is not done"), systemImage: "checkmark.circle")
                                }
                            })
                            Button(role: .destructive) {
                                modelContext.delete(items[i])
                            } label: {
                                Label(String(localized: "BUTTON.REMOVE_ENTRY", comment: "The slide action/button to delete an item"), image: "trash")
                            }
                        }
                    /*
                        .swipeActions(edge: .leading) {
                            NavigationLink(destination: AddView()) {
                                Label(String(localized: "BUTTON.EDIT", comment: "The slide action/button to edit an item"), systemImage: "pencil")
                            }
                        }
                     */
                }
            }
            .sheet(isPresented: $editorPresented, content: {
                AddView()
            })
            .toolbar {
                ToolbarItem {
                    Button {
                        editorPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationTitle("STRING.LIST_VIEW.TITLE")
    }
}

#Preview {
    HomeworkListView()
        .modelContainer(for: Homework.self, inMemory: true)
}
