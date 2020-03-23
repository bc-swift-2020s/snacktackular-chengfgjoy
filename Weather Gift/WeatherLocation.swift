//
//  WeatherLocation.swift
//  Weather Gift
//
//  Created by cheng jiayi on 2020/3/12.
//  Copyright © 2020 cheng jiayi. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    var name : String
    var latitude : Double
    var longtitude: Double
    
    init(name: String, latitude: Double, longtitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longtitude = longtitude
    }
    
    
   }
