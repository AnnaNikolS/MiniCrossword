# Mini-Crossword

Mini-Crossword — это простая библиотека для создания и отображения кроссвордов c 2 вертикальными словами по 4 буквы и 1 горизонтальным словом из 5 букв. Библиотека позволяет легко задавать слова, вопросы, пересекающиеся буквы и настраивать цвета ячеек кроссворда.

## Возможности

- Поддержка вертикальных и горизонтальных слов
- Задание пересекающихся букв
- Кастомизация цветов ячеек
- Отображение вопросов под кроссвордом
- Проверка правильности введённых слов

## Установка

### Swift Package Manager

1. Откройте проект в Xcode.
2. Перейдите в `File > Swift Packages > Add Package Dependency`.
3. Введите URL репозитория:

   ```bash
   https://github.com/AnnaNikolS/MiniCrossword.git
   
4. Используйте пакет в своем проекте. Ниже представлен код для демонстрации работы пакета:

   ```swift
   import UIKit
   import MiniCrossword

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCrossword()
    }
    
    private func setupCrossword() {
        // Вопросы для кроссворда
        let questions = [
            "1. Чем едят суп? (гориз. 1)",
            "2. Насекомое, которое ест одежду? (верт. 1)",
            "3. Что остается после дождя? (верт. 2)"
        ]
        
        // Вертикальные и горизонтальные слова
        let verticalWord1 = ["М", "О", "Л", "Ь"]
        let verticalWord2 = ["Л", "У", "Ж", "А"]
        let horizontalWord = ["Л", "О", "Ж", "К", "А"]
        
        // Пересекающиеся буквы и их координаты
        let intersectionLetters: [CGPoint: String] = [
            CGPoint(x: 1, y: 2): "Л",
            CGPoint(x: 3, y: 2): "Ж"
        ]
        
        // Настройка цвета активных ячеек
        let cellColor = UIColor.systemPink.withAlphaComponent(0.5)
        
        // Создание объекта данных для кроссворда
        let crosswordData = CrosswordData(
            verticalWord1: verticalWord1,
            verticalWord2: verticalWord2,
            horizontalWord: horizontalWord,
            intersectionLetters: intersectionLetters,
            questions: questions,
            cellColor: cellColor
        )
        
        // Создание и отображение контроллера кроссворда
        let crosswordViewController = CrosswordViewController(crosswordData: crosswordData)
        addChild(crosswordViewController)
        crosswordViewController.view.frame = view.bounds
        view.addSubview(crosswordViewController.view)
        crosswordViewController.didMove(toParent: self)
    }
}


