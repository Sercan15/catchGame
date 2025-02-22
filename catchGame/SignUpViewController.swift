//
//  SignUpViewController.swift
//  catchGame
//
//  Created by Sercan Yeşilyurt on 13.02.2025.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func continueButtonTapped(_ sender: UIButton) {
        guard let username = nameTextField.text, !username.isEmpty else {
            showAlert(message: "Lütfen bir isim girin")
            return
        }

        // Kullanıcı adını sakla
        UserDefaults.standard.set(username, forKey: "username")

        // Seviye Seçim Ekranına Geç
        performSegue(withIdentifier: "toLevelSelection", sender: nil)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}
