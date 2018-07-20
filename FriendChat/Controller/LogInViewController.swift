//
//  LogInViewController.swift
//  FriendChat
//
//  Created by Phi Hoang Huy on 7/13/18.
//  Copyright © 2018 Phi Hoang Huy. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ProgressHUD
class LogInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil
            {
                print(error!)
                SVProgressHUD.dismiss()
                ProgressHUD.showError(error?.localizedDescription)
            } else {
            ProgressHUD.showSuccess(error?.localizedDescription)
                SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "goToChat", sender: self)
        }
    }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
