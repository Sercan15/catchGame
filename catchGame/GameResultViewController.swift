//
//  GameResultViewController.swift
//  catchGame
//
//  Created by Sercan Yeşilyurt on 13.02.2025.
//

import UIKit

class GameResultViewController: UIViewController {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var congratulationLabel: UILabel!
    @IBOutlet weak var topScoresLabel: UILabel!
    
    
    var playerName: String?
    var difficulty: String?
    var score: Int = 0
    var isNewRecord: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        playerNameLabel.text = "Oyuncu Adı: \(playerName ?? "-")"
        difficultyLabel.text = "Seviye: \(difficulty ?? "-")"
        scoreLabel.text = "Puan: \(score)"

        print("Yeni Rekor Durumu: \(isNewRecord)") // Konsolda yeni rekor bilgisini görelim

        if isNewRecord {
            congratulationLabel.isHidden = false
            congratulationLabel.text = "🎉 Tebrikler! Yeni Rekor 🎉"
        } else {
            congratulationLabel.isHidden = true
        }
        // İlk 3 skoru yükle
        loadTopScores()
    }

    
    @IBAction func playAgainTapped(_ sender: UIButton) {
            if let navigationController = navigationController {
                    navigationController.popToRootViewController(animated: true)
                } else {
                    dismiss(animated: true, completion: nil)
                }
        }
    func loadTopScores() {
        let difficulty = UserDefaults.standard.value(forKey: "squirrelAppearDuration") as? TimeInterval ?? 1.5
        let difficultyKey = difficulty == 1.5 ? "scoresEasy" : (difficulty == 1.0 ? "scoresMedium" : "scoresHard")

        // Kullanıcı puanlarını al
        let highScores = UserDefaults.standard.array(forKey: difficultyKey) as? [[String: Any]] ?? []

        // Eğer hiç skor yoksa, ekrana bunu yaz
        guard !highScores.isEmpty else {
            topScoresLabel.text = "🏆 En Yüksek Skorlar:\nHenüz kayıtlı skor yok."
            return
        }

        var scoresText = "🏆 En Yüksek Skorlar:\n"
        for (index, entry) in highScores.enumerated() {
            if let name = entry["name"] as? String, let score = entry["score"] as? Int {
                scoresText += "\(index + 1). \(name) - \(score)\n"
            }
        }

        print("📌 Güncellenmiş skor listesi:\n\(scoresText)") // Konsolda kontrol et

        topScoresLabel.text = scoresText
    }

}
