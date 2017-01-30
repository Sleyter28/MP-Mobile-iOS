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
    @IBOutlet weak var btnLogin: UIButton!
    
    let dato = UserDefaults()
    
    //este es el metodo del boton login con lo cual se accede a la aplicacion
    @IBAction func btnLogin(_ sender: AnyObject) {
        let email = txtEmail.text
        let password = txtPassword.text
        
        
        
        if (email!.isEmpty || password!.isEmpty){
            let alertController = UIAlertController(title: "Inicio de Sesión fallido!", message: "El campo 'Email' o 'Contraseña' están en vacíos!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // ...
            }
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true) {
                // ...
            }
            
        }
            
        else{
            
            data_request()
            
            let homeView = storyboard?.instantiateViewController(withIdentifier: "revealViewController")
            present(homeView!, animated: true, completion: nil)
            
        }
        
    }
    //dentro de este metodo se coloca los atributos de la ventana y lo que se desea cambiar de estos.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.cornerRadius = 12
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = UIColor.white.cgColor
    }
    
    func data_request()
    {
        //esto quiere decir que esta obligando a la variable url a un tipo determinado
        let url:URL = URL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/loginS1.php")!
        _ = URLSession.shared
        
        //este toma el valor de url y lo envia por Post
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        //toma el valor de email y lo envia
        let paramString = "email="+txtEmail.text!
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            //
            let dataString: String = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
            let dictionary: Dictionary = self.convertToDictionary(text: dataString)!
            
            let dbName : String = dictionary["DB_name"] as! String
            //print (dbName)
            self.data_request_2(dbName)
            self.dato.setValue(dbName, forKey: "dbName")
        }
        task.resume()
    }
    
    func data_request_2(_ DB_name: String)
    {
        let url:URL = URL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/loginS2.php")!
        _ = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "email="+txtEmail.text!+"&"+"password="+txtPassword.text!+"&"+"DB_name="+DB_name
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            guard let _:Data = data, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            let dataString:String = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
            let dictionary: Dictionary = self.convertToDictionary(text: dataString)!
            //print(dictionary)
            let idComp : String = dictionary["id_company"] as! String
            self.dato.setValue(idComp, forKey: "id_company")
        }
        task.resume()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
