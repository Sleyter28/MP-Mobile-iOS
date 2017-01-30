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
    
    let dato = UserDefaults.standard
    
    let typeCredit = ["Crédito", "Contado"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barStyle = UIBarStyle.blackOpaque
        navigationController!.navigationBar.tintColor = UIColor.white
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.closeTaskService("1", completionHandler: { (response) -> () in
            //print(response)
        })
        self.closeTaskService("2", completionHandler: { (response) -> () in
            //print(response)
        })
        
        //Contado
        let cont: Double = self.dato.object(forKey: "Contado") as! Double
        
        
        //Credito
        let cred : Double = self.dato.object(forKey: "Credito") as! Double
        
        
        //Setting values of labels
        self.lblContado.text = "¢"+String(cont)
        self.lblContado.textColor = UIColor.white
        self.lblContado.font = lblContado.font.withSize(16)
        self.lblContado.textAlignment = NSTextAlignment.right
        
        
        self.lblCredito.text = "¢"+String(cred)
        self.lblCredito.textColor = UIColor.white
        self.lblCredito.font = lblContado.font.withSize(16)
        self.lblCredito.textAlignment = NSTextAlignment.right
        
        //Setting values of PieChart
        setChart(typeCredit, values: [cont,cred])
    }
    
    
    func closeTaskService(_ tipo: String, completionHandler: (_ response:NSString) -> ()) {
        let fecha = getCurrentDay()
        
        let db = self.dato.string(forKey: "dbName")
        
        let idC = self.dato.string(forKey: "id_company")
    
        let request = NSMutableURLRequest(url: URL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/home.php")!)
        request.httpMethod = "POST"
        let preparams : String? = "fecha="+fecha+"&"+"DB_name="+db!;
        let postParams = preparams!+"&"+"id_company="+idC!
        print(postParams)
        request.httpBody = postParams.data(using: String.Encoding.utf8)
        //let dataTask = session.dataTask(with: request as URLRequest) {data,response,error in
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let data = data,
                let html = String(data: data, encoding: String.Encoding.utf8) {
                //print("responseString = "+(responseString as String))
                switch tipo{
                    case "1":
                        let montoCont: Dictionary = self.convertToDictionary(text: html)!
                        let val1 : Double = montoCont["monto"] as! Double
                        self.dato.set(val1, forKey: "Contado")
                    
                    case "2":
                        //print("Entre al 2")
                        let montoCred: Dictionary = self.convertToDictionary(text: html)!
                        let val2 : Double = montoCred["monto"] as! Double
                        self.dato.set(val2, forKey: "Credito")
                    
                    default:
                        self.dato.setValue("0", forKey: "Contado")
                        self.dato.setValue("0", forKey: "Credito")
                }
            }
        }
        task.resume()
    }
    
    func getCurrentDay ()->String{
        let todaysDate:Date = Date()
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let todayString:String = dateFormatter.string(from: todaysDate)
        return todayString
    }
    
    func setChart(_ dataPoints: [String], values: [Double]){
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: " ")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
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
