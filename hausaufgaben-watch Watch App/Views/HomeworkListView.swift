//
//  HomeworkListView.swift
//  hausaufgaben Watch App
//
//  Created by Linus Warnatz on 12.10.23.
//

import SwiftUI
import SwiftData

struct HomeworkListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var editorPresented = false
    @Query(sort: \Homework.dueDate, order: .forward)
    var items: [Homework]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        ItemDetailView(item: item)
                    } label: {
                        ListItemView(item: item)
                    }
                }
            }
            .navigationTitle("STRING.LIST_VIEW.TITLE")
            .sheet(isPresented: $editorPresented, content: {
                AddView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
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
        .modelContainer(for: Homework.self, inMemory: true)
}
