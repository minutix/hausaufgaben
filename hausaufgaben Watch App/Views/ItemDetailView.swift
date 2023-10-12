//
//  ItemDetailView.swift
//  hausaufgaben Watch App
//
//  Created by Linus Warnatz on 12.10.23.
//

import SwiftUI
import SwiftData

struct ItemDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Homework.dueDate, order: .forward)
    var items: [Homework]
    var item: Homework
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.lesson)
                        .bold()
                    Text(item.text)
                    if item.hasDueDate {
                        Text(item.dueDate.formatted(date: .numeric, time: .omitted))
                    }
                }
                Spacer()
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "checkmark.circle")
            }
            StarView(difficulty: item.difficulty)
            Button(item.isDone ? "BUTTON.WATCH.MARK_DONE": "BUTTON.WATCH.MARK_UNDONE") {
                items[items.firstIndex(of: item)!].isDone.toggle()
            }
            Button("BUTTON.WATCH.REMOVE_ENTRY", role: .destructive) {
                modelContext.delete(item)
                dismiss()
            }
        }
    }
}

#Preview {
    ItemDetailView(item: Homework(difficulty: 3, dueDate: Date(), lesson: "NwT", text: "Test"))
}
