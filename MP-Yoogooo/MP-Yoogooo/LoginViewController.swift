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
    
    let dato = NSUserDefaults()
    
    @IBAction func btnLogin(sender: AnyObject) {
        let email = txtEmail.text
        let password = txtPassword.text
        
        
        
        if (email!.isEmpty || password!.isEmpty){
            let alertController = UIAlertController(title: "Inicio de Sesión fallido!", message: "El campo 'Email' o 'Contraseña' están en vacíos!", preferredStyle: .Alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // ...
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                // ...
            }
            
        }
        else{
            
            data_request()
            
            let homeView = storyboard?.instantiateViewControllerWithIdentifier("revealViewController")
            presentViewController(homeView!, animated: true, completion: nil)
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func data_request()
    {
        let url:NSURL = NSURL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/loginS1.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "email="+txtEmail.text!
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            let dataString = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            //let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let db_Name = dataString["DB_name"]
            //print(db_Name)
            let db_Name1: String? = db_Name as AnyObject? as? String
            //print(db_Name1)
            self.data_request_2(db_Name1!)
            //print(self.dato.objectForKey("dbName"))
        }
        
        task.resume()
    }
    
    func data_request_2(DB_name: String)
    {
        let url:NSURL = NSURL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/loginS2.php")!
        let session = NSURLSession.sharedSession()
        self.dato.setValue(DB_name, forKey: "dbName")
        //print("The name of db is: "+DB_name)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "email="+txtEmail.text!+"&"+"password="+txtPassword.text!+"&"+"DB_name="+DB_name
        //print(paramString)
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print(dataString)
            
        }
        
        task.resume()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
}
