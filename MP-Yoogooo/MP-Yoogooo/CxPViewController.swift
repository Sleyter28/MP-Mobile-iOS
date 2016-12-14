//
//  CxPViewController.swift
//  MP-Yoogooo
//
//  Created by Sleyter Angulo on 11/24/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import UIKit

class CxPViewController: UIViewController {

    @IBOutlet weak var txtSearch: UISearchBar!
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
        let search: String = txtSearch.text!
        print(search)
//        self.closeTaskService(search, completionHandler: { (response) -> () in
//            print(response)
//        })
        
    }
    
//    func closeTaskService(_ valor: String, completionHandler: (_ response:NSString) -> ()) {
//        let request = NSMutableURLRequest(url: URL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/CxP.php")!)
//        let db = self.dato.object(forKey: "dbName")
//        let db1 = db as AnyObject? as? String
//        let dbName : String = (db1 as AnyObject? as? String)!
//        request.httpMethod = "POST"
//        let postParams = "DB_name="+dbName+"&"+"valor=%"+valor+"%"
//        print(postParams)
//        request.httpBody = postParams.data(using: String.Encoding.utf8)
//        let task = URLSession.shared.dataTask(with: request, completionHandler: {
//            data, response, error in
//            //print("response = \(response)") //imprime los datos del servidor al que me conecte
//            let responseString: NSString = NSString(data: data!, encoding: String.Encoding.utf8)!
//            print("responseString = "+(responseString as String))
//        }) 
//        task.resume()
//    }
    

}
