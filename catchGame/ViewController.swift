//
//  ViewController.swift
//  catchGame
//
//  Created by Sercan Yeşilyurt on 7.02.2025.
//

import UIKit

class ViewController: UIViewController {
    
    // VIEWS
    @IBOutlet weak var squirrel1: UIImageView!
    @IBOutlet weak var squirrel2: UIImageView!
    @IBOutlet weak var squirrel3: UIImageView!
    @IBOutlet weak var squirrel4: UIImageView!
    @IBOutlet weak var squirrel5: UIImageView!
    @IBOutlet weak var squirrel6: UIImageView!
    @IBOutlet weak var squirrel7: UIImageView!
    @IBOutlet weak var squirrel8: UIImageView!
    
    // LABELS
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // VARIABLES
    var score = 0
    var timer = Timer()
    var counter = 0
    var squirrelArray: [UIImageView] = []
    var hideTimer = Timer()
    var highScore = UserDefaults.standard.integer(forKey: "highScore")
    
    // Seviye seçimine göre sincapların ekrana geliş süresi
    var squirrelAppearDuration: TimeInterval = 1.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        styleLabel(scoreLabel)
        styleLabel(timeLabel)
        
        // Kullanıcının seçtiği süreyi al
        if let savedDuration = UserDefaults.standard.value(forKey: "squirrelAppearDuration") as? TimeInterval {
            squirrelAppearDuration = savedDuration
        }
        
        // Kullanıcının oynadığı seviyeye göre en yüksek skoru al
        let difficulty = UserDefaults.standard.value(forKey: "squirrelAppearDuration") as? TimeInterval ?? 1.5
        let difficultyKey = difficulty == 1.5 ? "highScoreEasy" : (difficulty == 1.0 ? "highScoreMedium" : "highScoreHard")
           
        let currentHighScore = UserDefaults.standard.integer(forKey: difficultyKey)
           
        // High Score'u seviyeye göre güncelle
        highScoreLabel.text = "High Score (\(difficultyKey)): \(currentHighScore)"
        
        // Labels
        scoreLabel.text = "Score: \(score)"
        
        // Views
        squirrelArray = [squirrel1, squirrel2, squirrel3, squirrel4, squirrel5, squirrel6, squirrel7, squirrel8]
        for squirrel in squirrelArray {
            squirrel.isUserInteractionEnabled = true
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(squirrelTapped))
            squirrel.addGestureRecognizer(recognizer)
        }
        
        startGame()
    }
    
    // Start Game
    func startGame() {
        score = 0
        counter = 10
        scoreLabel.text = "Score: \(score)"
        timeLabel.text = String(counter)
        
        timer.invalidate()
        hideTimer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: squirrelAppearDuration, target: self, selector: #selector(hideSquirrel), userInfo: nil, repeats: true)
        
        hideSquirrel()
    }

    // Hide Squirrel
    @objc func hideSquirrel() {
        for squirrel in squirrelArray {
            squirrel.isHidden = true
        }
        let randomIndex = Int(arc4random_uniform(UInt32(squirrelArray.count)))
        squirrelArray[randomIndex].isHidden = false
    }
    
    // Squirrel Tapped
    @objc func squirrelTapped() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    // Countdown Function
    @objc func countdown() {
        counter -= 1
        timeLabel.text = String(counter)

        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()

            let isNewRecord = checkHighScore()

            // Oyuncu ismini al
            let playerName = UserDefaults.standard.string(forKey: "username") ?? "Bilinmiyor"

            // Skoru kaydet
            saveHighScore(playerName: playerName, score: score)

            // Sonuç ekranına git
            goToGameResultScreen(isNewRecord: isNewRecord)
        }
    }

    
    // Yeni rekoru kontrol et
    func checkHighScore() -> Bool {
        let difficulty = UserDefaults.standard.value(forKey: "squirrelAppearDuration") as? TimeInterval ?? 1.5
        let difficultyKey = difficulty == 1.5 ? "highScoreEasy" : (difficulty == 1.0 ? "highScoreMedium" : "highScoreHard")
        
        let currentHighScore = UserDefaults.standard.integer(forKey: difficultyKey)

        print("📌 Şu anki yüksek skor (\(difficultyKey)): \(currentHighScore), Yeni Skor: \(score)")

        if score > currentHighScore {
            print("✅ Yeni rekor kırıldı! \(difficultyKey) güncellendi.")
            UserDefaults.standard.set(score, forKey: difficultyKey)
            UserDefaults.standard.synchronize()
            
            // Yeni rekoru anında güncelle
            highScoreLabel.text = "High Score (\(difficultyKey)): \(score)"
            
            return true
        } else {
            print("❌ Yeni rekor kırılmadı.")
        }
        return false
    }

    // Sonuç ekranına geçiş
    func goToGameResultScreen(isNewRecord: Bool) {
        print("📌 Sonuç ekranına gidiyoruz. Yeni rekor durumu: \(isNewRecord)")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toGameResult", sender: isNewRecord)
        }
    }


    // Bilgileri sonuç ekranına gönder
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameResult" {
            if let resultVC = segue.destination as? GameResultViewController {
                let playerName = UserDefaults.standard.string(forKey: "username") ?? "Bilinmiyor"
                let difficulty = UserDefaults.standard.value(forKey: "squirrelAppearDuration") as? TimeInterval ?? 1.5
                let difficultyString = difficulty == 1.5 ? "Kolay" : (difficulty == 1.0 ? "Orta" : "Zor")

                let isNewRecord = sender as? Bool ?? false

                print("📌 GameResultViewController'a gidiyoruz. Yeni rekor durumu: \(isNewRecord)")

                resultVC.playerName = playerName
                resultVC.difficulty = difficultyString
                resultVC.score = score
                resultVC.isNewRecord = isNewRecord
            }
        }
    }
    
    func saveHighScore(playerName: String, score: Int) {
        let difficulty = UserDefaults.standard.value(forKey: "squirrelAppearDuration") as? TimeInterval ?? 1.5
        let difficultyKey = difficulty == 1.5 ? "scoresEasy" : (difficulty == 1.0 ? "scoresMedium" : "scoresHard")

        // Önce mevcut skorları al
        var highScores = UserDefaults.standard.array(forKey: difficultyKey) as? [[String: Any]] ?? []

        // Yeni skoru listeye ekle
        highScores.append(["name": playerName, "score": score])

        // Skorları büyükten küçüğe sırala
        highScores.sort { ($0["score"] as! Int) > ($1["score"] as! Int) }

        // İlk 3 kaydı sakla
        highScores = Array(highScores.prefix(3))

        // Güncellenmiş listeyi kaydet
        UserDefaults.standard.set(highScores, forKey: difficultyKey)
        UserDefaults.standard.synchronize()
    }
    //func of views
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func styleLabel(_ label: UILabel) {
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next Bold", size: 24)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }

    



}

