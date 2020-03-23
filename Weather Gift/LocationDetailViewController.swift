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
    
    @IBOutlet weak var pageControl: UIPageControl!
    
   
    var locationIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       updateUserInterface()
    }
    
  
    func updateUserInterface(){
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        let weatherLocation = pageViewController.weatherLocations[locationIndex]
        let weatherDetail = WeatherDetail(name: weatherLocation.name, latitude: weatherLocation.latitude, longtitude: weatherLocation.longtitude)
        
      
        
        pageControl.numberOfPages = pageViewController.weatherLocations.count
        pageControl.currentPage = locationIndex
        
        weatherDetail.getData{
            DispatchQueue.main.async {

                self.dateLabel.text = weatherDetail.timezone
            self.placeLabel.text = weatherDetail.name
                self.temperatureLabel.text = "\(weatherDetail.temperature)"
                self.summaryLabel.text = weatherDetail.summary
                self.imageVIew.image = UIImage(named: weatherDetail.dailyIcon)
    }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
         let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        destination.weatherLocations = pageViewController.weatherLocations
    }
   
    @IBAction func unwindFromLocationListViewController(segue: UIStoryboardSegue){
        let source = segue.source as! ViewController
        locationIndex = source.selectedLocationIndex
        
         let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        pageViewController.weatherLocations = source.weatherLocations
        pageViewController.setViewControllers([pageViewController.createLocationDetailViewController(forPage: locationIndex)], direction:  .forward, animated: false, completion: nil)
    }
    @IBAction func pageControlTapped(_ sender: UIPageControl) {
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
       
        var direction: UIPageViewController.NavigationDirection = .forward
        if sender.currentPage < locationIndex{
            direction = .reverse
        }
        pageViewController.setViewControllers([pageViewController.createLocationDetailViewController(forPage: sender.currentPage)], direction: direction, animated: true, completion: nil)
    }
     
}
