//
//  ViewController.swift
//  LoginTest
//
//  Created by Ememobong Akpanekpo on 09/10/2019.
//  Copyright © 2019 Ememobong Akpanekpo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookLogin


class ViewController: UIViewController, UITextFieldDelegate, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameTextField: DesignableUITextField!
    @IBOutlet weak var passwordTextField: DesignableUITextField!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    var activeTextField: DesignableUITextField?
    var lastOffSet = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.userNameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user if signed in already
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        
    }
    
    @IBAction func login(_ sender: Any) {
        let email = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        signIn(email, password)
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
    
    func signIn(_ email: String, _ password: String){
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
        
            // ...
            if let user = authResult?.user {
                self?.showAlertMessge(message: "Login successful 👍")
            } else {
                self?.showAlertMessge(message: "Login failed 😢")
            }
        }
    }
    
    
    @IBAction func facebookSignIn(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(
            permissions: [.publicProfile, .userFriends],
            viewController: self
        ) { result in
            self.loginManagerDidComplete(result)
        }
    }
    
    
    @IBAction func googleSignIn(_ sender: Any) {
        
    }
    
    
    func loginManagerDidComplete(_ result: LoginResult) {
        let alertController: UIAlertController
        switch result {
        case .cancelled:
            showAlertMessge(message: "User cancelled login.")
            
        case .failed(let error):
            showAlertMessge(message: "Login failed with error \(error)")
            
        case .success(let grantedPermissions, _, _):
            showAlertMessge(message: "Login succeeded with granted permissions: \(grantedPermissions)")
        }
    }
}

