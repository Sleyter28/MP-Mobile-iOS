//
//  CxPViewController.swift
//  MP-Yoogooo
//
//  Created by Sleyter Angulo on 11/24/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import UIKit
import Alamofire

class CxPViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var listData:[[String : AnyObject]] = [[String : AnyObject]]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let dato = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
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
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar!) -> String{
        let search: String = txtSearch.text!
        print(search)
        
        let db = self.dato.object(forKey: "dbName")
        let dbName : String = db as Any as! String
        
        let id = self.dato.object(forKey: "id_company")
        let idComp : String = id as Any as! String
        
        let parameters : Parameters = ["id_company":idComp,"DB_name":dbName,"valor":"%"+search+"%"]
        
        Alamofire.request( "http://demomp2015.yoogooo.com/demoMovil/Web-Service/CxP.php", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: [:]).responseJSON(completionHandler: { response in
            
            print(response)
            switch response.result{
            case .success:
                self.listData = response.result.value as! [[String:AnyObject]]
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        })
        
        return search
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCxP", for: indexPath)
        
        let item = self.listData[indexPath.row]
        cell.textLabel?.text = item["cuota"] as? String
        
        
        return cell
    }

    

}
