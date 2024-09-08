//
//  CrosswordViewController.swift
//
//
//  Created by Анна on 08.09.2024.
//

import UIKit

public class CrosswordViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var crosswordData: CrosswordData
    private var userAnswers: [[String]] = []
    private var collectionView: UICollectionView!
    
    public init(crosswordData: CrosswordData) {
        self.crosswordData = crosswordData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUserAnswers()
        prefillCrossword()
        setupCollectionView()
        setupCheckButton()
        setupQuestions()
    }
    
    private func setupUserAnswers() {
        // Определение размера кроссворда динамически на основе слов
        let maxRows = max(crosswordData.verticalWords.map { $0.count }.max() ?? 0,
                          crosswordData.horizontalWords.map { $0.count }.max() ?? 0)
        let maxCols = max(crosswordData.verticalWords.count,
                          crosswordData.horizontalWords.count)
        userAnswers = Array(repeating: Array(repeating: "", count: maxCols + 2), count: maxRows + 2)
    }
    
    // Заполнение пересекающихся букв
    private func prefillCrossword() {
        for (point, letter) in crosswordData.intersectionLetters {
            let row = Int(point.x)
            let col = Int(point.y)
            guard row < userAnswers.count, col < userAnswers[row].count else { continue }
            userAnswers[row][col] = letter
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        collectionView = UICollectionView(frame: CGRect(x: 20, y: UIScreen.main.bounds.height / 3, width: view.bounds.width - 40, height: view.bounds.width - 40), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CrosswordCell.self, forCellWithReuseIdentifier: "CrosswordCell")
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
    }
    
    private func setupCheckButton() {
        let checkButton = UIButton(type: .system)
        checkButton.setTitle("Проверить", for: .normal)
        checkButton.addTarget(self, action: #selector(checkCrossword), for: .touchUpInside)
        checkButton.frame = CGRect(x: 20, y: view.bounds.height - 150, width: view.bounds.width - 40, height: 50)
        checkButton.backgroundColor = .systemBlue
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.layer.cornerRadius = 10
        view.addSubview(checkButton)
    }
    
    private func setupQuestions() {
        for (index, question) in crosswordData.questions.enumerated() {
            let questionLabel = UILabel(frame: CGRect(x: 24, y: view.bounds.height * 2/3 + CGFloat(index * 24), width: view.bounds.width - 32, height: 20))
            questionLabel.text = question
            questionLabel.textAlignment = .left
            view.addSubview(questionLabel)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userAnswers.count * userAnswers[0].count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CrosswordCell", for: indexPath) as! CrosswordCell
        let row = indexPath.item / userAnswers[0].count
        let col = indexPath.item % userAnswers[0].count
        
        let isPartOfWord = isPartOfWord(row: row, col: col)
        cell.configureForCrossword(isPartOfWord: isPartOfWord, color: isPartOfWord ? crosswordData.cellColor : .clear)
        cell.setLetter(userAnswers[row][col])
        
        return cell
    }
    
    private func isPartOfWord(row: Int, col: Int) -> Bool {
        for word in crosswordData.verticalWords {
            if col == 1 && row < word.count {
                return true
            }
        }
        for word in crosswordData.horizontalWords {
            if row == 2 && col < word.count + 1 {
                return true
            }
        }
        return false
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item / userAnswers[0].count
        let col = indexPath.item % userAnswers[0].count
        
        if isPartOfWord(row: row, col: col) {
            let alert = UIAlertController(title: "Введите букву", message: nil, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Буква"
            }
            let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                if let letter = alert.textFields?.first?.text?.uppercased(), letter.count == 1 {
                    self?.userAnswers[row][col] = letter
                    self?.collectionView.reloadItems(at: [indexPath])
                }
            }
            alert.addAction(confirmAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc public func checkCrossword() {
        var isCorrect = true
        
        // Проверка вертикальных слов
        for (_, word) in crosswordData.verticalWords.enumerated() {
            for (j, letter) in word.enumerated() {
                if userAnswers[j][1] != letter {
                    isCorrect = false
                    break
                }
            }
            if !isCorrect { break }
        }
        
        // Проверка горизонтальных слов
        if isCorrect {
            for (_, word) in crosswordData.horizontalWords.enumerated() {
                for (j, letter) in word.enumerated() {
                    if userAnswers[2][j + 1] != letter {
                        isCorrect = false
                        break
                    }
                }
                if !isCorrect { break }
            }
        }
        
        let alert = UIAlertController(title: isCorrect ? "Правильно!" : "Ошибка!", message: isCorrect ? "Вы правильно заполнили кроссворд." : "Попробуйте еще раз.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = 4 * CGFloat(userAnswers[0].count - 1)
        let size = (collectionView.frame.width - totalSpacing) / CGFloat(userAnswers[0].count)
        return CGSize(width: size, height: size)
    }
}
