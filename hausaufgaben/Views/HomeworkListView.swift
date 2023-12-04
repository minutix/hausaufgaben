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
        NavigationView {
            List {
                ForEach(0..<items.count, id: \.self) { i in
                    ListItemView(item: items[i])
                        .padding()
                        .swipeActions(edge: .trailing) {
                            Button(action: {
                                items[i].isDone.toggle()
                            }, label:{
                                if items[i].isDone {
                                    Label("BUTTON.MARK_UNDONE", systemImage: "xmark.circle")
                                } else {
                                    Label("BUTTON.MARK_DONE", systemImage: "checkmark.circle")
                                }
                            })
                            Button {
                                modelContext.delete(items[i])
                            } label: {
                                Label("BUTTON.REMOVE_ENTRY", image: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            NavigationLink(destination: AddView()) {
                                Label("BUTTON.EDIT", systemImage: "pencil")
                            }
                        }
                }
            }
            .sheet(isPresented: $editorPresented, content: {
                AddView()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
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
}
