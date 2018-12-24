//
//  TypesViewController.swift
//  Never Ever
//
//  Created by Marina Lunts on 12/24/18.
//  Copyright © 2018 earine. All rights reserved.
//

import UIKit

class TypesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["Всё подряд", "Весёлое", "Пошлое"]
    
    var selectedType : String = ""
    var selecredType2 : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        cell.layer.cornerRadius = 20.0
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowRadius = 12.0
        cell.layer.shadowOpacity = 0.7
        cell.backgroundImage.image = UIImage(named: "\(indexPath.item + 1).png")
        cell.myLabel.text = self.items[indexPath.item]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if (indexPath.item == 0) {
            selectedType = "adult"
            selecredType2 = "non-adult"
        } else if (indexPath.item == 1) {
            selectedType = "non-adult"
        } else {
            selectedType = "adult"
        }
        performSegue(withIdentifier: "goToCards", sender: nil)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToCards") {
            let CCards = segue.destination as! CardsViewController
            CCards.type = selectedType
            if (!selecredType2.isEmpty) {
                CCards.type2 = selecredType2
            }
        }
    }
    
}

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
}
