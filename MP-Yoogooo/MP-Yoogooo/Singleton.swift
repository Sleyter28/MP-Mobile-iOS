//
//  Singleton.swift
//  MP-Yoogooo
//
//  Created by Sleyter Angulo on 12/1/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import UIKit

class Singleton1 {
    static let sharedInstance = Singleton1()
    
    var dbName = ""
    var propiedad = 0
    init() {
        //print("Inicializando")
        print(dbName)
    }
    
}
