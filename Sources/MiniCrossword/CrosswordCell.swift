//
//  CrosswordCell.swift
//
//
//  Created by Анна on 08.09.2024.
//

import UIKit

public class CrosswordCell: UICollectionViewCell {
    
    private var letterLabel: UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        letterLabel = UILabel(frame: contentView.bounds)
        letterLabel.textAlignment = .center
        letterLabel.font = UIFont.systemFont(ofSize: 24)
        contentView.addSubview(letterLabel)
    }
    
    public func configureForCrossword(isPartOfWord: Bool, color: UIColor) {
        contentView.backgroundColor = isPartOfWord ? color : .clear
        contentView.layer.cornerRadius = 8
    }
    
    public func setLetter(_ letter: String) {
        letterLabel.text = letter
    }
}
