//
//  HomeViewController.swift
//  MP-Yoogooo
//  Created by Sleyter Angulo on 11/24/16.
//  Copyright © 2016 Sleyter Angulo. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {
    
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let typeCredit = ["Credito", "Contacto"]
        let monto = [768725.0,509548.0]
        
        setChart(typeCredit, values: monto)
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    func setChart(xAxisLabels: [String], values: [Double]){
        barChart.noDataText = "No se pudo obtener los datos"
        barChart.noDataTextDescription = "Error"
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<xAxisLabels.count{
            dataEntries.append(BarChartDataEntry(value: values[i], xIndex: i))
        }
        
        let charDataSet = BarChartDataSet (yVals: dataEntries, label: "Weight")
        let chartData = BarChartData (xVals: xAxisLabels, dataSet: charDataSet)
        barChart.data = chartData
        
    }
    
    
    
}
