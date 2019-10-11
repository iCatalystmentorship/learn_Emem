//
//  ViewController.swift
//  LoginTest
//
//  Created by Ememobong Akpanekpo on 09/10/2019.
//  Copyright © 2019 Ememobong Akpanekpo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: DesignableUITextField!
    @IBOutlet weak var passwordTextField: DesignableUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        showAlertMessge(message: "Logged in successful 👍")
    }
    
    @IBAction func signUp(_ sender: Any) {
        showAlertMessge(message: "Signup not done 😢")
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        showAlertMessge(message: "Forgot password not done 😢")
    }
    
    
    func showAlertMessge(message: String) {
        let alertVC = UIAlertController(title: "🆕 Message", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}

