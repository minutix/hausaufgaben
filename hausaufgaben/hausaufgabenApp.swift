//
//  hausaufgabenApp.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
//

import SwiftUI

@main
struct hausaufgabenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Entries())
        }
    }
}

struct Homework: Hashable {
    var lesson: String
    var text: String
    var dueDate: Date?
    var isDone = false
}

final class Entries: ObservableObject {
    @Published var listContent: [Homework] = []
}
