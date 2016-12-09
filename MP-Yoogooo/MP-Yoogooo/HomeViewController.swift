//
//  HomeViewController.swift
//  MP-Yoogooo
//  Created by Sleyter Angulo on 11/24/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var lblContado: UILabel!
    @IBOutlet weak var lblCredito: UILabel!
    
    let dato = NSUserDefaults()
    
    let typeCredit = ["Crédito", "Contado"]
    
    
    private var monto:[Double] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.closeTaskService("1", completionHandler: { (response) -> () in
            print(response)
        })
        self.closeTaskService("2", completionHandler: { (response) -> () in
            print(response)
        })
        
        //Contado
        let cont = self.dato.objectForKey("Contado")
        let monCon = cont as AnyObject? as? String
        let valCont:String = (monCon as AnyObject? as? String)!
        print("monto contado: "+String(valCont))
        let conValue = atoi(String(valCont))
        
        //Credito
        let cred = self.dato.objectForKey("Credito")
        let monCred = cred as AnyObject? as? String
        let valCred:String = (monCred as AnyObject? as? String)!
        print("monto credito: "+String(valCred))
        let credValue = atoi(String(valCred))
        
        //Setting values of labels
        self.lblContado.text = "¢"+valCont
        self.lblCredito.text = "¢"+valCred
        
        //Setting values of PieChart
        setChart(typeCredit, values: [conValue,credValue])
    }
    
    func atoi (valor: String)->Double{
        //print(valor)
        let value = (valor as NSString).doubleValue
        //print("el valor es: "+String(value))
        return value
    }
    
    func closeTaskService(tipo: String, completionHandler: (response:NSString) -> ()) {
        let fecha = getCurrentDay()
        let request = NSMutableURLRequest(URL: NSURL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/home.php")!)
        let db = self.dato.objectForKey("dbName")
        let db1 = db as AnyObject? as? String
        let dbName : String = (db1 as AnyObject? as? String)!
        print(dbName)
        request.HTTPMethod = "POST"
        let postParams = "fecha="+fecha+"&"+"DB_name="+dbName+"&"+"tipo="+tipo
        print(postParams)
        request.HTTPBody = postParams.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            //print("response = \(response)") imprime los datos del servidor al que me conecte
            let responseString: NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            //print("responseString = "+(responseString as String))
            switch tipo{
                
                case "1":
                    print("Entre al 1")
                    self.dato.setValue(responseString as String, forKey: "Contado")
                    print(self.dato.objectForKey("Contado"))
                case "2":
                    print("Entre al 2")
                    self.dato.setValue(responseString as String, forKey: "Credito")
                    print(self.dato.objectForKey("Credito"))
                default:
                    self.dato.setValue("0", forKey: "Contado")
                    self.dato.setValue("0", forKey: "Credito")
            }
        }
        task.resume()
    }
    
    func getCurrentDay ()->String{
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let todayString:String = dateFormatter.stringFromDate(todaysDate)
        //print(todayString)
        return todayString
    }
    
    func setChart(dataPoints: [String], values: [Double]){
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        pieChartDataSet.colors = colors
    }
    
}

