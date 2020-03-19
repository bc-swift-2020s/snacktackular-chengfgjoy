//
//  LocationDetailViewController.swift
//  Weather Gift
//
//  Created by cheng jiayi on 2020/3/18.
//  Copyright © 2020 cheng jiayi. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    var weatherLocation: WeatherLocation!
    var weatherLocations: [WeatherLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if weatherLocation == nil{
            weatherLocation = WeatherLocation(name: "Current Location", latitude: 0.0, longtitude: 0.0)
            weatherLocations.append(weatherLocation)
        }
       updateUserInterface()
    }
    func updateUserInterface(){
        dateLabel.text = ""
        placeLabel.text = weatherLocation.name
        temperatureLabel.text = "--°"
        summaryLabel.text = ""
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        destination.weatherLocations = weatherLocations
    }
   
    @IBAction func unwindFromLocationListViewController(segue: UIStoryboardSegue){
        let source = segue.source as! ViewController
        weatherLocations = source.weatherLocations
        weatherLocation = weatherLocations[source.selectedLocationIndex]
        updateUserInterface()
    }

}
