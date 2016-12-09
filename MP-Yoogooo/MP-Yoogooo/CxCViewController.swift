//
//  CxCViewController.swift
//  MP-Yoogooo
//
//  Created by Sleyter Angulo on 11/24/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import UIKit

class CxCViewController: UIViewController {

    @IBOutlet weak var txtBusqueda: UISearchBar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let dato = NSUserDefaults()
    
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
    
    func searchBarSearchButtonClicked( searchBar: UISearchBar!)
    {
        let search: String = txtBusqueda.text!
        self.closeTaskService(search, completionHandler: { (response) -> () in
            print(response)
        })
        
    }
    
    func closeTaskService(valor: String, completionHandler: (response:NSString) -> ()) {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/CxC.php")!)
        let db = self.dato.objectForKey("dbName")
        let db1 = db as AnyObject? as? String
        let dbName : String = (db1 as AnyObject? as? String)!
        request.HTTPMethod = "POST"
        let postParams = "DB_name="+dbName+"&"+"valor=%"+valor+"%"
        print(postParams)
        request.HTTPBody = postParams.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            //print("response = \(response)") //imprime los datos del servidor al que me conecte
            let responseString: NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print("responseString = "+(responseString as String))
        }
        task.resume()
    }

}
