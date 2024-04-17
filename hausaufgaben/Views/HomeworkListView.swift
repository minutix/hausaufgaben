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
                        .contextMenu(menuItems: {
                            Button(role: .destructive) {
                                modelContext.delete(items[i])
                            } label: {
                                Label(String(localized: "REMOVE_ITEM", comment: "The slide action/button to delete an item"), image: "trash")
                            }
                            Button(action: {
                                items[i].isDone.toggle()
                            }, label:{
                                if items[i].isDone {
                                    Label(String(localized: "UNDONE_BUTTON", comment: "The \"Mark Undone\" slide action/button in the list or detail view, when the item is already done"), systemImage: "xmark.circle")
                                } else {
                                    Label(String(localized: "DONE_BUTTON", comment: "The \"Mark Undone\" slide action/button in the list or detail view, when the item is not done"), systemImage: "checkmark.circle")
                                }
                            })
                        })
                        .padding()
                        .swipeActions(edge: .trailing) {
                            Button(action: {
                                items[i].isDone.toggle()
                            }, label:{
                                if items[i].isDone {
                                    Label(String(localized: "MARK_UNDONE", comment: "The \"Mark Undone\" slide action/button in the list or detail view, when the item is already done"), systemImage: "xmark.circle")
                                } else {
                                    Label(String(localized: "MARK_DONE", comment: "The \"Mark Undone\" slide action/button in the list or detail view, when the item is not done"), systemImage: "checkmark.circle")
                                }
                            })
                            Button(role: .destructive) {
                                modelContext.delete(items[i])
                            } label: {
                                Label(String(localized: "REMOVE_ITEM", comment: "The slide action/button to delete an item"), systemImage: "trash")
                            }
                        }
                    /*
                        .swipeActions(edge: .leading) {
                            NavigationLink(destination: AddView()) {
                                Label(String(localized: "EDIT_ITEM", comment: "The slide action/button to edit an item"), systemImage: "pencil")
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
        .navigationTitle("HappyWork")
    }
}

#Preview {
    HomeworkListView()
        .modelContainer(for: Homework.self, inMemory: true)
}
