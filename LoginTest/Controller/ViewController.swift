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
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        // ...
        
        
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear!")
        let user = GIDSignIn.sharedInstance()?.currentUser
        if user != nil {
            print("user is not nil")
            self.moveToWelcomeScreen()
        }
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
        let alertVC = UIAlertController(title: "Message 🆕", message: message, preferredStyle: .alert)
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
//                self?.showAlertMessge(message: "Login successful 👍")
                self?.moveToWelcomeScreen()
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
        switch result {
        case .cancelled:
            showAlertMessge(message: "User cancelled login.")
            
        case .failed(let error):
            showAlertMessge(message: "Login failed with error \(error)")
            
        case .success(let grantedPermissions, _, _):
//            showAlertMessge(message: "Login succeeded with granted permissions: \(grantedPermissions)")
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    self.showAlertMessge(message: "Couldn't sign in to firebase. \(error)")
                    return
                }
//                self.showAlertMessge(message: "Firebase facebook sign in successful")
                self.moveToWelcomeScreen()
            }
        }
    }
    
    
    func moveToWelcomeScreen(){
        performSegue(withIdentifier: "welcome", sender: self)
    }
}

