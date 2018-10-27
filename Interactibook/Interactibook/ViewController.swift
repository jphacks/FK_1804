//
//  ViewController.swift
//  Interactibook
//
//  Created by 仲地早司 on 2018/10/27.
//  Copyright © 2018年 仲地早司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        recommendCollectionView.dataSource = self
        listCollectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDataSource {
    /*
    func recommendCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func listCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func recommendCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let recommendcell = recommendCollectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath)
        recommendcell.backgroundColor = .green
        
        return recommendcell
    }
    
    func listCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let listcell = recommendCollectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath)
        listcell.backgroundColor = .red
        
        return listcell
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .green
        
        return cell
    }
}
