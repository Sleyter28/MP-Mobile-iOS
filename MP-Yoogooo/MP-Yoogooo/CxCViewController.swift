//
//  CxCViewController.swift
//  MP-Yoogooo
//
//  Created by Sleyter Angulo on 11/24/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import UIKit
import Foundation

class CxCViewController: UIViewController {

    @IBOutlet weak var txtBusqueda: UISearchBar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let dato = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar!)
    {
        let search: String = txtBusqueda.text!
        self.closeTaskService(search, completionHandler: { (response) -> () in
            print(response)
        })
        
    }
    
    func closeTaskService(_ valor: String, completionHandler: (_ response:NSString) -> ()) {
        var i = 0
        let request = NSMutableURLRequest(url: URL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/CxC.php")!)
        let db = self.dato.object(forKey: "dbName")
        let db1 = db as AnyObject? as? String
        let dbName : String = (db1 as AnyObject? as? String)!
        let idC = self.dato.object(forKey: "id_company")
        let idComp : String = idC as Any as! String
        
        request.httpMethod = "POST"
        let postParams = "DB_name="+dbName+"&"+"id_company="+idComp+"valor=%"+valor+"%"
        request.httpBody = postParams.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error ) in
            //print("response = \(response)") //imprime los datos del servidor al que me conecte
            let responseString: String = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            let numbers = responseString.replacingOccurrences(of: "[", with: "", options: .literal, range: nil)
            let numbers1 = numbers.replacingOccurrences(of: "]", with: "", options: .literal, range: nil)
            var number2: [String] = numbers1.components(separatedBy: ",\"+\"")
            let cont = number2.count - 1
            number2.remove(at: cont)
            
            while i < cont {
                //var dictionary: Dictionary <String,String> = [number2[i]]
                //print(dictionary)
                print(number2[i])
                i += 1
                
            }
            
        }
        task.resume()
    
    }
    
    func convertToDictionary(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
