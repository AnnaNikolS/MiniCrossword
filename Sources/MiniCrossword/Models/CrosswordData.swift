//
//  CrosswordData.swift
//
//
//  Created by Анна on 08.09.2024.
//

import UIKit

public struct CrosswordData {
    public let verticalWord1: [String]
    public let verticalWord2: [String] // Список вертикальных слов
    public let horizontalWord: [String] // Список горизонтальных слов
    public let intersectionLetters: [CGPoint: String] // Пересекающиеся буквы и их координаты
    public let questions: [String] // Список вопросов
    public let cellColor: UIColor // Цвет ячеек для слов

    public init(verticalWord1: [String], verticalWord2: [String], horizontalWord: [String], intersectionLetters: [CGPoint: String], questions: [String], cellColor: UIColor) {
        self.verticalWord1 = verticalWord1
        self.verticalWord2 = verticalWord2
        self.horizontalWord = horizontalWord
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


