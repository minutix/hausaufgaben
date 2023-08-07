//
//  Homework.swift
//  hausaufgaben
//
//  Created by Linus Warnatz on 07.08.23.
//
//

import Foundation
import SwiftData


@Model final public class Homework {
    var difficulty: Int16? = 0
    var dueDate: Date?
    var isDone: Bool?
    var lesson: String?
    var text: String?
    
}
