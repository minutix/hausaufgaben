//
//  ContentView.swift
//  hausaufgaben Watch App
//
//  Created by Linus Warnatz on 12.10.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeworkListView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Homework.self, inMemory: true)
}
