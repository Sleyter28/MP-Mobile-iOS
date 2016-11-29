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
    
    let dbName = "demomovil"
    let typeCredit = ["Crédito", "Contado"]
    var contado = 0.0
    var credito = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //data_request(dbName, tipo: "1")
        let monto = [768725.0,509548.0]
        setChart(typeCredit, values: monto)
        
        getCurrentDay()
        
        self.closeTaskService("1", completionHandler: { (response) -> () in
            //print(response)
            self.contado = (response as NSString).doubleValue
            self.lblContado.text = "¢"+String(self.contado)
            print(self.contado)
        })
        self.closeTaskService("2", completionHandler: { (response) -> () in
            //print(response)
            self.credito = (response as NSString).doubleValue
            self.lblCredito.text = "¢"+String(self.credito)
            print(self.credito)
        })
        
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
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
    
    func closeTaskService(tipo: String, completionHandler: (response: NSString) -> ()) {
        let fecha = getCurrentDay()
        print(fecha)
        let request = NSMutableURLRequest(URL: NSURL(string: "http://demomp2015.yoogooo.com/demoMovil/Web-Service/home.php")!)
        request.HTTPMethod = "POST"
        let postParams = "fecha="+fecha+"&"+"DB_name="+dbName+"&"+"tipo="+tipo
        
        request.HTTPBody = postParams.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            //print("response = \(response)")
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print("responseString = \(responseString!)")
            completionHandler(response: responseString!)
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
        
}

