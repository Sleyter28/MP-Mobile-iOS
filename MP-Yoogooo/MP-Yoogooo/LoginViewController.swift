//
//  LoginViewController.swift
//  MP-Yoogooo
//
//  Created by Sleyter Angulo on 11/28/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var values:NSArray = []
    
    @IBAction func btnLogin(sender: AnyObject) {
        let email = txtEmail.text
        let password = txtPassword.text
        
        if (email!.isEmpty || password!.isEmpty){
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Inicio de Sesión fallido!"
            alertView.message = "El campo 'Email' o 'contraseña' están en vacíos!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        }
        else{
            let homeView = storyboard?.instantiateViewControllerWithIdentifier("revealViewController")
            presentViewController(homeView!, animated: true, completion: nil)
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
