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
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.lesson )
                                .font(.headline)
                            Text("\(item.text ) \(item.hasDueDate ? "—" : "" ) \(item.dueDate.formatted(date: .numeric, time: .omitted))")
                            StarView(difficulty: Int(item.difficulty))
                            .font(.footnote)
                        }
                        Spacer()
                        Button {
                            items[items.firstIndex(of: item)!].isDone.toggle()
                        } label: {
                            Image(systemName: "checkmark.circle\(item.isDone ? ".fill" : "")")
                        }
                    }
                    .padding()
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("STRING.LIST_VIEW.TITLE")
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
    }
}

#Preview {
    HomeworkListView()
}
