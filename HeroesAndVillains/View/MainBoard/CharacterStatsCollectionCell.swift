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
    lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    lazy var characterInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    lazy var characterStatsGraph: BarChartView = {
        let statGraph = BarChartView()
        
        return statGraph
    }()
    
    var characterStats: CharacterStats?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
//    override init(style: UICollectionViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        commonInit()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func commonInit() {
        
        setupCharacterImageView()
        setupCharacterNameLabel()
        setupCharacterInfoLabel()
        setupCharacterStatsGraph()
    }
    
    func setupCharacterImageView(){
        addSubview(characterImageView)
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leftAnchor),
            characterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            characterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25)
            ])
    }
    
    func setupCharacterNameLabel(){
        addSubview(characterNameLabel)
        NSLayoutConstraint.activate([
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.topAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 5),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterNameLabel.heightAnchor.constraint(equalTo: characterImageView.heightAnchor, multiplier: 0.2)
            ])
    }
    
    func setupCharacterInfoLabel(){
        addSubview(characterInfoLabel)
        NSLayoutConstraint.activate([
            characterInfoLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor),
            characterInfoLabel.leftAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            characterInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterInfoLabel.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor)
            ])
        
    }
    
    func setupCharacterStatsGraph(){
        addSubview(characterImageView)
        NSLayoutConstraint.activate([
            characterStatsGraph.topAnchor.constraint(equalTo: characterImageView.bottomAnchor),
            characterStatsGraph.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            characterStatsGraph.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterStatsGraph.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
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
        characterStatsGraph.animate(yAxisDuration: 3)
        characterStatsGraph.leftAxis.axisMaximum = 110
        characterStatsGraph.leftAxis.axisMinimum = 0
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
