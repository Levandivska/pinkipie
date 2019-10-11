//
//  StatsVC.swift
//  NewVersionPinkiePie
//
//  Created by Taras Mazurkevych on 09.10.2019.
//  Copyright © 2019 Veronika Romanko. All rights reserved.
//

import UIKit
import Charts

class StatsVC: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var textView: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Line Chart 1"
        
        let foodData = FoodData()
        textView.text = String(format:"%f", foodData.getCaloriesbyDate("06-06-2019"))
        chart.delegate = self
        
        chart.chartDescription?.enabled = false
        chart.dragEnabled = true
        chart.setScaleEnabled(true)
        chart.pinchZoomEnabled = true
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .bottomRight
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        chart.xAxis.gridLineDashLengths = [10, 10]
        chart.xAxis.gridLineDashPhase = 0
        
        let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .topRight
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: -30, label: "Lower Limit")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .bottomRight
        ll2.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = chart.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 200
        leftAxis.axisMinimum = -50
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chart.rightAxis.enabled = false

        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chart
        marker.minimumSize = CGSize(width: 80, height: 40)
        chart.marker = marker
        
        chart.legend.form = .line
        

        chart.animate(xAxisDuration: 2.5)

        self.updateChartData()
    }
    
    func updateChartData() {
        self.setDataCount(Int(45), range: UInt32(100))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let foodData = FoodData()
        var values = [ChartDataEntry]();
        
        let ti:TimeInterval = 24*60*60
        let dateTo = Date()
        let dateFrom = dateTo.addingTimeInterval(-ti*30)
        var nextDate = dateFrom
        var xAxis = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        while nextDate.compare(dateTo) != ComparisonResult.orderedDescending
        {
            values.append(ChartDataEntry(x: Double(xAxis), y: foodData.getCaloriesbyDate(formatter.string(from: nextDate)).reduce(0, +), icon: #imageLiteral(resourceName: "Statistics")))
            nextDate = nextDate.addingTimeInterval(ti)
            xAxis += 1
        }
        
        let set1 = LineChartDataSet(entries: values, label: "")
        set1.drawIconsEnabled = false
        
        set1.lineDashLengths = [5, 2.5]
        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.black)
        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 9)
        set1.formLineDashLengths = [5, 2.5]
        set1.formLineWidth = 1
        set1.formSize = 15
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        chart.data = data
    }
}
