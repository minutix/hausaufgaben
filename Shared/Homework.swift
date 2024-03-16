//
//  Homework.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 07.08.23.
//
//

import Foundation
import SwiftData


@Model
final public class Homework: Identifiable {
    var difficulty: Int = 0
    var hasDueDate: Bool = false
    var dueDate: Date = Date()
    var isDone: Bool = false
    var lesson: String = ""
    var text: String = ""
    init(difficulty: Int, dueDate: Date?, lesson: String, text: String) {
        self.difficulty = difficulty
        self.hasDueDate = dueDate != nil
        self.dueDate = dueDate ?? Date()
        self.isDone = false
        self.lesson = lesson
        self.text = text
    }
}
