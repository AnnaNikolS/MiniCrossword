//
//  CrosswordViewController.swift
//
//
//  Created by Анна on 08.09.2024.
//

import UIKit

import UIKit

public class CrosswordViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let crosswordData: CrosswordData
    private var userAnswers: [[String]] = []
    private var collectionView: UICollectionView!

    public init(crosswordData: CrosswordData) {
        self.crosswordData = crosswordData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        userAnswers = Array(repeating: Array(repeating: "", count: 7), count: 7)
        prefillCrossword()
        
        setupCollectionView()
        setupCheckButton()
        setupQuestions()
    }
    
    // Заполнение пересекающихся букв
    private func prefillCrossword() {
        for (point, letter) in crosswordData.intersectionLetters {
            userAnswers[Int(point.y)][Int(point.x)] = letter
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
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
        checkButton.frame = CGRect(x: 20, y: view.bounds.height - 100, width: view.bounds.width - 40, height: 50)
        checkButton.backgroundColor = .systemBlue
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.layer.cornerRadius = 10
        view.addSubview(checkButton)
    }
    
    private func setupQuestions() {
        var yOffset: CGFloat = 40
        for question in crosswordData.questions {
            let questionLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: view.bounds.width - 40, height: 20))
            questionLabel.text = question
            questionLabel.textAlignment = .left
            view.addSubview(questionLabel)
            yOffset += 30
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 * 7
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CrosswordCell", for: indexPath) as! CrosswordCell
        
        let row = indexPath.item / 7
        let col = indexPath.item % 7
        
        let isPartOfWord = crosswordData.verticalWords.contains(where: { $0.indices.contains(row) && $0[row] == userAnswers[row][col] }) ||
                           crosswordData.horizontalWords.contains(where: { $0.indices.contains(col) && $0[col] == userAnswers[row][col] })
        
        cell.setLetter(userAnswers[row][col])
        cell.configureForCrossword(isPartOfWord: isPartOfWord, color: crosswordData.cellColor)
        
        return cell
    }
    
    // Ввод буквы при выборе ячейки
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item / 7
        let col = indexPath.item % 7
        
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
    
    // Проверка кроссворда
    @objc private func checkCrossword() {
        var isCorrect = true
        
        for (i, word) in crosswordData.verticalWords.enumerated() {
            for (j, letter) in word.enumerated() {
                if userAnswers[j][i] != letter {
                    isCorrect = false
                    break
                }
            }
        }
        
        for (i, word) in crosswordData.horizontalWords.enumerated() {
            for (j, letter) in word.enumerated() {
                if userAnswers[i][j] != letter {
                    isCorrect = false
                    break
                }
            }
        }
        
        let alert = UIAlertController(title: isCorrect ? "Правильно!" : "Ошибка!", message: isCorrect ? "Вы правильно заполнили кроссворд." : "Попробуйте еще раз.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing: CGFloat = 4 * 6
        let size = (collectionView.frame.width - totalSpacing) / 7
        return CGSize(width: size, height: size)
    }
}
