//
//  LogInViewController.swift
//  Geocaching
//
//  Created by Adrián Silva on 22/1/18.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.view.tintColor = .white
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        //TODO: Log in the user
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) {
            (user, error) in
            if error != nil {
                print(error!)
            } else {
                self.performSegue(withIdentifier: "fromNewToTabBar", sender: self)
            }
        }
    }
}
