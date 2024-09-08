//
//  CrosswordCell.swift
//
//
//  Created by Анна on 08.09.2024.
//

import UIKit

public class CrosswordCell: UICollectionViewCell {
    
    private var letterLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        letterLabel = UILabel(frame: contentView.bounds)
        letterLabel.textAlignment = .center
        letterLabel.font = UIFont.systemFont(ofSize: 24)
        letterLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(letterLabel)
        
        NSLayoutConstraint.activate([
            letterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            letterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            letterLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            letterLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    public func configureForCrossword(isPartOfWord: Bool, color: UIColor) {
        contentView.backgroundColor = isPartOfWord ? color.withAlphaComponent(0.5) : .clear
        contentView.layer.cornerRadius = 8
    }
    
    public func setLetter(_ letter: String) {
        letterLabel.text = letter
    }
}
