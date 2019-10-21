//
//  ViewController.swift
//  LoginTest
//
//  Created by Ememobong Akpanekpo on 09/10/2019.
//  Copyright © 2019 Ememobong Akpanekpo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: DesignableUITextField!
    @IBOutlet weak var passwordTextField: DesignableUITextField!
    
    var activeTextField: DesignableUITextField?
    var lastOffSet = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
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
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        activeTextField = textField as DesignableUITextField
//        lastOffSet = self.scrollView.contentOffset
//        return true
//    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeTextField = nil
        return true
    }
    
}

