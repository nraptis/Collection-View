//
//  GridView.swift
//  CollectionViewParametric
//
//  Created by Nicky Taylor on 8/7/24.
//

import UIKit

class GridView: UIView {

    static let cellIdentifier = "cell"
    
    init() {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))
        self.backgroundColor = UIColor(red: 0.05, green: 0.06, blue: 0.08, alpha: 1.0)
        
        addSubview(collectionView)
        addConstraints([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        
        UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            func calculateNumberOfCols(cellMaximumWidth: CGFloat,
                                       effectiveContentWidth: CGFloat,
                                       groupContentInsetLeft: CGFloat,
                                       groupContentInsetRight: CGFloat,
                                       interItemSpacingH: CGFloat) -> Int {
                var numberOfCols = 1
                let availableWidth = effectiveContentWidth - CGFloat(groupContentInsetLeft + groupContentInsetRight)
                var horizontalCount = 2
                while horizontalCount < 32 {
                    let totalSpaceWidth = CGFloat(horizontalCount - 1) * interItemSpacingH
                    let availableWidthForCells = availableWidth - totalSpaceWidth
                    let expectedCellWidth = availableWidthForCells / CGFloat(horizontalCount)
                    if expectedCellWidth < CGFloat(cellMaximumWidth) {
                        break
                    } else {
                        numberOfCols = horizontalCount
                        horizontalCount += 1
                    }
                }
                return numberOfCols
            }
            
            func calculateCellWidth(numberOfCols: Int,
                                    minimumWidth: CGFloat,
                                    effectiveContentWidth: CGFloat,
                                    groupContentInsetLeft: CGFloat,
                                    groupContentInsetRight: CGFloat,
                                    interItemSpacingH: CGFloat) -> CGFloat {
                if numberOfCols <= 0 {
                    return minimumWidth
                }
                
                var totalSpace = effectiveContentWidth
                totalSpace -= groupContentInsetLeft
                totalSpace -= groupContentInsetRight
                
                //subtract out the space between cells!
                if numberOfCols > 1 {
                    totalSpace -= CGFloat(numberOfCols - 1) * interItemSpacingH
                }
                
                var cellWidth = totalSpace / CGFloat(numberOfCols)
                cellWidth = CGFloat(Int(cellWidth))
                
                if cellWidth < minimumWidth {
                    cellWidth = minimumWidth
                }
                return cellWidth
            }
            
            // I want cells widths no bigger than x
            let cellMaximumWidth = (UIDevice.current.userInterfaceIdiom == .pad) ? CGFloat(150.0) : CGFloat(90.0)
            
            // I want cell heights exactly width + x
            let cellExtraHeight = (UIDevice.current.userInterfaceIdiom == .pad) ? CGFloat(36.0) : CGFloat(28.0)
            
            // I want exactly x horizontal spacing between cells.
            let interItemSpacingH = CGFloat(9.0)
            
            // I want eactly x padding at left of screen.
            let groupContentInsetLeft = CGFloat(24.0)
            
            // I want eactly x padding at right of screen.
            let groupContentInsetRight = CGFloat(24.0)
            
            // I want exactly x vertical  spacing between cells.
            let interItemSpacingV = CGFloat(9.0)
            
            // I want exactly x padding at top of screen.
            //let groupContentInsetTop = CGFloat(24.0) // Handle with UICollectionView.contentInset
            
            // I want exactly x padding at bottom of screen.
            //let groupContentInsetBottom = CGFloat(128.0) // Handle with UICollectionView.contentInset
            
            let effectiveContentSize = layoutEnvironment.container.effectiveContentSize
            let numberOfCols = calculateNumberOfCols(cellMaximumWidth: cellMaximumWidth,
                                                     effectiveContentWidth: effectiveContentSize.width,
                                                     groupContentInsetLeft: groupContentInsetLeft,
                                                     groupContentInsetRight: groupContentInsetRight,
                                                     interItemSpacingH: interItemSpacingH)
            let cellWidth = calculateCellWidth(numberOfCols: numberOfCols,
                                               minimumWidth: 16.0,
                                               effectiveContentWidth: effectiveContentSize.width,
                                               groupContentInsetLeft: groupContentInsetLeft,
                                               groupContentInsetRight: groupContentInsetRight,
                                               interItemSpacingH: interItemSpacingH)
            let cellHeight = cellWidth + cellExtraHeight
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(cellWidth),
                                                  heightDimension: .absolute(cellHeight))
            var items = [NSCollectionLayoutItem(layoutSize: itemSize)]
            
            // When you rotate, if using .fractionalWidth(), this whole block is called again.
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(cellHeight))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
            
            group.contentInsets = .init(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
            group.edgeSpacing = .init(leading: .fixed(groupContentInsetLeft),
                                      top: .fixed(0.0),
                                      trailing: nil,
                                      bottom: .fixed(0.0))
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(interItemSpacingH)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = interItemSpacingV
            return section
        }
    }()
    
    lazy var collectionView: UICollectionView = {
        let result = UICollectionView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0),
                                      collectionViewLayout: compositionalLayout)
        result.translatesAutoresizingMaskIntoConstraints = false
        result.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: Self.cellIdentifier)
        result.dataSource = self
        result.backgroundColor = UIColor.clear
        
        // I want exactly x padding at top of screen.
        let groupContentInsetTop = CGFloat(24.0)
        
        // I want exactly x padding at bottom of screen.
        let groupContentInsetBottom = CGFloat(128.0)
        
        result.contentInset = UIEdgeInsets(top: groupContentInsetTop,
                                           left: 0.0,
                                           bottom: groupContentInsetBottom,
                                           right: 0.0)
        return result
    }()
    
}

extension GridView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 256
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellIdentifier, for: indexPath)
    }
}
