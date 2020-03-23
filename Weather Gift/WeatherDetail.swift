//
//  WeatherDetail.swift
//  Weather Gift
//
//  Created by cheng jiayi on 2020/3/20.
//  Copyright © 2020 cheng jiayi. All rights reserved.
//

import Foundation

class WeatherDetail: WeatherLocation{
    
    struct Result: Codable{
        var timezone: String
        var currently: Currently
        var daily: Daily
    }
    struct Currently: Codable{
        var temperature: Double
    }
    struct Daily: Codable{
        var summary: String
        var icon: String
    }
    var timezone = ""
    var temperature = 0
    var summary = ""
    var dailyIcon = ""
    
    func getData(completed: @escaping () -> () ) {
            let coordinates = "\(latitude),\(longtitude)"
            let urlString = "\(APIurls.darkSkyURL)\(APIkets.darkSkyKey)/\(coordinates)"
    //        let urlString = "https://pokeapi.co/api/v2/pokemon"
            print("we are cretaing a url string: \(urlString)")
            
            guard let url = URL(string: urlString) else{
                print("Error: cannot create a url string from \(urlString)")
                completed()
                return
            }
            
            let session =  URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error{
                    print("Error: \(error.localizedDescription)")
                }
                do {
                    let result = try JSONDecoder().decode(Result.self, from: data!)
        
                    self.timezone = result.timezone
                    self.temperature = Int(result.currently.temperature.rounded())
                    self.summary = result.daily.summary
                    self.dailyIcon = result.daily.icon
                }catch{
                    print("JSON Error: \(error.localizedDescription)")
                }
                completed()
            }
            task.resume()
        }
    
}
