//
//  SingletonT.swift
//  MP-Yoogooo
//
//  Created by Sleyter Angulo on 12/2/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import Foundation

class Singleton {
    static let sharedInstance = Singleton()
    
    var dbName: String = ""
    var contado: Double = 0.0
    
    
    // METHODS
    init() {
        
        print(#function)
    }
    func displayDBName() -> String {
        return self.dbName
    }
    func incrementGameScore(name: String) {
        self.dbName = name
    }
    func setContado (monto : Double){
        self.contado = monto
        print(self.contado)
    }
    func getContado() -> Double {
        return self.contado
    }
}
