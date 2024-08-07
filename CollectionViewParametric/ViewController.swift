//
//  ViewController.swift
//  CollectionViewParametric
//
//  Created by Nicky Taylor on 8/7/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var toolbarTop: UIView = {
        let result = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))
        result.translatesAutoresizingMaskIntoConstraints = false
        result.backgroundColor = UIColor(red: 0.14, green: 0.15, blue: 0.18, alpha: 1.0)
        return result
    }()
    
    lazy var toolbarBottom: UIView = {
        let result = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))
        result.translatesAutoresizingMaskIntoConstraints = false
        result.backgroundColor = UIColor(red: 0.14, green: 0.15, blue: 0.18, alpha: 1.0)
        return result
    }()
    
    lazy var gridView: GridView = {
        let result = GridView()
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(toolbarTop)
        view.addConstraints([
            toolbarTop.topAnchor.constraint(equalTo: view.topAnchor),
            toolbarTop.leftAnchor.constraint(equalTo: view.leftAnchor),
            toolbarTop.rightAnchor.constraint(equalTo: view.rightAnchor),
            toolbarTop.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44.0)
        ])
        
        view.addSubview(toolbarBottom)
        view.addConstraints([
            toolbarBottom.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toolbarBottom.leftAnchor.constraint(equalTo: view.leftAnchor),
            toolbarBottom.rightAnchor.constraint(equalTo: view.rightAnchor),
            toolbarBottom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -44.0)
        ])
        
        view.addSubview(gridView)
        view.addConstraints([
            gridView.topAnchor.constraint(equalTo: toolbarTop.bottomAnchor),
            gridView.leftAnchor.constraint(equalTo: view.leftAnchor),
            gridView.rightAnchor.constraint(equalTo: view.rightAnchor),
            gridView.bottomAnchor.constraint(equalTo: toolbarBottom.topAnchor)
        ])
        
    }


}

