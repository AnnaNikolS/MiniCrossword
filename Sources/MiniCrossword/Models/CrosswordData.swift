//
//  CrosswordData.swift
//
//
//  Created by Анна on 08.09.2024.
//

import UIKit

public struct CrosswordData {
    public let verticalWords: [[String]] // Список вертикальных слов
    public let horizontalWords: [[String]] // Список горизонтальных слов
    public let intersectionLetters: [CGPoint: String] // Пересекающиеся буквы и их координаты
    public let questions: [String] // Список вопросов
    public let cellColor: UIColor // Цвет ячеек для слов

    public init(verticalWords: [[String]], horizontalWords: [[String]], intersectionLetters: [CGPoint: String], questions: [String], cellColor: UIColor) {
        self.verticalWords = verticalWords
        self.horizontalWords = horizontalWords
        self.intersectionLetters = intersectionLetters
        self.questions = questions
        self.cellColor = cellColor
    }
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}


