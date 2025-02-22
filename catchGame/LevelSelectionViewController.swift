//
//  LevelSelectionViewController.swift
//  catchGame
//
//  Created by Sercan Yeşilyurt on 13.02.2025.
//

import UIKit

class LevelSelectionViewController: UIViewController {
    
    
    @IBOutlet weak var difficultySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startGameButtonTapped(_ sender: UIButton) {
        
        var difficulty: TimeInterval = 1.5

        switch difficultySegment.selectedSegmentIndex {
        case 0:
            difficulty = 1.5 // Kolay
        case 1:
            difficulty = 1.0 // Orta
        case 2:
            difficulty = 0.5 // Zor
        default:
            break
        }

        // Seçilen zorluk seviyesini kaydet
        UserDefaults.standard.set(difficulty, forKey: "squirrelAppearDuration")

        // Oyun Ekranına Geç
        performSegue(withIdentifier: "toGameScreen", sender: nil)
    }
    
   
}
