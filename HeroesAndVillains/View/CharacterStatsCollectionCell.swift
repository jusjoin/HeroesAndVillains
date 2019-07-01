//
//  HeroStatsCollectionCell.swift
//  HeroesAndVillains
//
//  Created by Zane on 6/28/19.
//  Copyright © 2019 Z. All rights reserved.
//

import UIKit
import Charts

class CharacterStatsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterInfoTextView: UITextView!
//    @IBOutlet weak var characterStatsScrollView: UIScrollView!
    @IBOutlet weak var characterStatsGraph: BarChartView!
    
    var characterStats: CharacterStats?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    func updateGraph(charStats: CharacterStats){
        
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(charStats.powerstats.combat) ?? 0.0)
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(charStats.powerstats.durability) ?? 0.0)
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(charStats.powerstats.intelligence) ?? 0.0)
        let entry4 = BarChartDataEntry(x: 4.0, y: Double(charStats.powerstats.power) ?? 0.0)
        let entry5 = BarChartDataEntry(x: 5.0, y: Double(charStats.powerstats.speed) ?? 0.0)
        let entry6 = BarChartDataEntry(x: 6.0, y: Double(charStats.powerstats.strength)!)
        let dataSet1 = BarChartDataSet(entries: [entry1], label: "Combat")
        dataSet1.colors = ChartColorTemplates.colorful()
        let dataSet2 = BarChartDataSet(entries: [entry2], label: "Durability")
        dataSet2.colors = ChartColorTemplates.joyful()
        let dataSet3 = BarChartDataSet(entries: [entry3], label: "Intelligence")
        dataSet3.colors = ChartColorTemplates.liberty()
        let dataSet4 = BarChartDataSet(entries: [entry4], label: "Power")
        dataSet4.colors = ChartColorTemplates.material()
        let dataSet5 = BarChartDataSet(entries: [entry5], label: "Speed")
        dataSet5.colors = ChartColorTemplates.pastel()
        let dataSet6 = BarChartDataSet(entries: [entry6], label: "Strength")
        let data = BarChartData(dataSets: [dataSet1, dataSet2, dataSet3, dataSet4, dataSet5, dataSet6])
        characterStatsGraph.data = data
        //characterStatsGraph.chartDescription?.text = "Character attributes"
        
        let leftAxis = characterStatsGraph.leftAxis
        leftAxis.enabled = false
        let xAxis = characterStatsGraph.xAxis
        xAxis.enabled = false
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        characterStatsGraph.notifyDataSetChanged()
        
        
        //Code for simple radarGraph
//        var  entries = [RadarChartDataEntry]()
//        entries.append(RadarChartDataEntry(value: 10))
//        entries.append(RadarChartDataEntry(value: 13))
//        entries.append(RadarChartDataEntry(value: 24))
//        let set1 = RadarChartDataSet(entries: entries, label: "Attributes")
//        let data = RadarChartData(dataSet: set1)
//        characterStatsGraph.data = data
//        characterStatsGraph.chartDescription?.text = "Character's Attributes"
//
//        //All other additions to this function will go here
//
//        //This must stay at end of function
//        characterStatsGraph.notifyDataSetChanged()
    }
    
    func configure(thisCharacter: CharacterStats){
        
        characterNameLabel.text = thisCharacter.name
        characterImageView.image = UIImage(named: thisCharacter.image.url)
        dlManager.download(thisCharacter.image.url) { [unowned self] dat in
            
            if let data = dat {
                
                let image = UIImage(data: data)
                self.characterImageView.image = image
            }
        }

        updateGraph(charStats: thisCharacter)
        
    }
}
