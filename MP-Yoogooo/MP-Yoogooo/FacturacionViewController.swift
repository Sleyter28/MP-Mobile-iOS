//
//  FacturacionViewController.swift
//  MP-Yoogooo
//
//  Created by Sleyter Angulo on 11/24/16.
//  Copyright © 2016 Sleyter Angulo. All trights reserved.
//

import UIKit

class FacturacionViewController: UIViewController {
    

    @IBOutlet weak var txtCantidad: UITextField!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var btnFacturar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        btnFacturar.layer.cornerRadius = 10
        btnFacturar.layer.borderWidth = 1
        btnFacturar.layer.borderColor = UIColor.black.cgColor
        
        txtCantidad.layer.borderColor = UIColor.yellow.cgColor
        
        
    }
}
