//
//  hausaufgabenApp.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 02.11.22.
//

import SwiftUI
import SwiftData

@main
struct hausaufgabenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Homework.self)
    }
}
