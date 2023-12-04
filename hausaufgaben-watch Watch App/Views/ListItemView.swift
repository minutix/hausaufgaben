//
//  ListItemView.swift
//  hausaufgaben Watch App
//
//  Created by Linus Warnatz on 12.10.23.
//

import SwiftUI

struct ListItemView: View {
    var item: Homework
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.lesson)
                    .bold()
                Text(item.text)
            }
            Spacer()
            Image(systemName: item.isDone ? "checkmark.circle.fill" : "checkmark.circle")
        }
        .padding()
    }
}

#Preview {
    List {
        ListItemView(item: Homework(difficulty: 3, dueDate: Date(), lesson: "NwT", text: "Test"))
        ListItemView(item: Homework(difficulty: 3, dueDate: Date(), lesson: "NwT", text: "Test"))
        ListItemView(item: Homework(difficulty: 3, dueDate: Date(), lesson: "NwT", text: "Test"))
    }
}
