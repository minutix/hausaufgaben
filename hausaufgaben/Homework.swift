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
final public class Homework {
    var difficulty: Int
    var hasDueDate: Bool
    var dueDate: Date
    var isDone: Bool
    var lesson: String
    var text: String
    init(difficulty: Int, dueDate: Date?, lesson: String, text: String) {
        self.difficulty = difficulty
        self.hasDueDate = dueDate != nil
        self.dueDate = dueDate ?? Date()
        self.isDone = false
        self.lesson = lesson
        self.text = text
    }
}
