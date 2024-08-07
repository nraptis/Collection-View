//
//  GridCollectionViewCell.swift
//  CollectionViewParametric
//
//  Created by Nicky Taylor on 8/7/24.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.67, green: 0.68, blue: 0.70, alpha: 1.0)
        layer.cornerRadius = 8.0
        clipsToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 0.96, green: 0.965, blue: 0.97, alpha: 1.0).cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

