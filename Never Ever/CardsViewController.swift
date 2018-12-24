//
//  ViewController.swift
//  Never Ever
//
//  Created by Marina Lunts on 12/24/18.
//  Copyright © 2018 earine. All rights reserved.
//

import UIKit
import SwiftyJSON

class CardsViewController: UIViewController {

    var phrases : [Phrase] = []
    var type : String = ""
    var type2 : String = ""
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var neverEverLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCardView()
        setCards()
        neverEverLabel.text = "\(phrases[Int(arc4random_uniform(UInt32(phrases.count)))].text)"
        
    }

    func setCards() {
        fetchJSON(type: type)
        if type2.count > 0 {
            fetchJSON(type: type2)
        }
    }
    
    func setCardView() {
        cardView.layer.cornerRadius = 20.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowRadius = 12.0
        cardView.layer.shadowOpacity = 0.7
    }

    func fetchJSON(type : String) {
        if let path = Bundle.main.path(forResource: "neverEverJSON", ofType: "json")
        {
            do{
                let pathAsData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                let json = try JSON(data: pathAsData as Data)
                
                for i in 0...json[type].array!.count - 1 {
                    phrases.append(Phrase(text: json[type][i]["phrase"].stringValue))
                }
            } catch{
                print("Some error")
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        newPhrase(removable: false)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        newPhrase(removable: true)
         backgroundImage.image = UIImage(named: "\(arc4random_uniform(13) + 1).png")
    }
    
    func newPhrase(removable : Bool) {
        if phrases.count > 0  {
            let randomIndex = Int(arc4random_uniform(UInt32(phrases.count)))
            neverEverLabel.text = "\(phrases[randomIndex].text)"
            
            if (removable) {
            phrases.remove(at: randomIndex)
            }
        } else {
            setCards()
        }
    }

   
}

