//
//  CdCViewController.swift
//  MP-Yoogooo
//
//  Created by Sleyter Angulo on 11/24/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import UIKit
import Alamofire

class CdCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var listData:[[String : AnyObject]] = [[String : AnyObject]]()

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var menuButton: UIBarButtonItem!
    let dato = UserDefaults()
    
    override func viewDidLoad() {
        let db = self.dato.object(forKey: "dbName")
        let dbName : String = db as Any as! String
        
        let id = self.dato.object(forKey: "id_company")
        let idComp : String = id as Any as! String
        
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
       
        
        let parameters : Parameters = ["DB_name":dbName,"id_company":idComp]
        
        Alamofire.request( "http://demomp2015.yoogooo.com/demoMovil/Web-Service/cierreCaja.php", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: [:]).responseJSON(completionHandler: { response in
            
            print(response)
            switch response.result{
            case .success:
                self.listData = response.result.value as! [[String:AnyObject]]
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCC", for: indexPath)
        
        let item = self.listData[indexPath.row]
        cell.textLabel?.text = item["facturas"] as? String
        
        
        return cell
    }
    
    
}
