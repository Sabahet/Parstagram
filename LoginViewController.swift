//
//  LoginViewController.swift
//  Parstagram2
//
//  Created by Sabahet Alovic on 10/19/20.
//  Copyright © 2020 Sabahet Alovic. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil{
                   self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("ERROR \(String(describing: error?.localizedDescription))")
            }
            
        }
    }
    @IBAction func signupButton(_ sender: Any) {
        let user = PFUser()
          user.username = usernameField.text
        user.password = passwordField.text
          user.signUpInBackground { (success, error) in
              if success{
                  self.performSegue(withIdentifier: "loginSegue", sender: nil)
              }
              print("ERROR \(String(describing: error?.localizedDescription))")
              
          }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
