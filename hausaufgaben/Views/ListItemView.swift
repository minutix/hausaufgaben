//
//  ListItemView.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 12.10.23.
//

import SwiftUI

struct ListItemView: View {
    var item: Homework
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.lesson )
                    .font(.headline)
                Text("\(item.text ) \(item.hasDueDate ? "—" : "" ) \(item.dueDate.formatted(date: .numeric, time: .omitted))")
                StarView(difficulty: Int(item.difficulty))
                .font(.footnote)
            }
            Spacer()
            Image(systemName: "checkmark.circle\(item.isDone ? ".fill" : "")")
            
        }
    }
}

#Preview {
    ListItemView(item: Homework(difficulty: 3, dueDate: Date(), lesson: "NwT", text: "Test"))
}
