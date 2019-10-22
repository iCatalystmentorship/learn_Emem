//
//  WelcomeViewController.swift
//  LoginTest
//
//  Created by Ememobong Akpanekpo on 22/10/2019.
//  Copyright © 2019 Ememobong Akpanekpo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func logoutUser(_ sender: Any) {
        
        let user = GIDSignIn.sharedInstance()?.currentUser
        if user != nil {
            googleSignOut()
        } else {
            facebookSignOut()
        }
    }
    
    func facebookSignOut(){
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            dismissController()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    func googleSignOut(){
        GIDSignIn.sharedInstance().signOut()
        dismissController()
    }
    
    func dismissController(){
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
