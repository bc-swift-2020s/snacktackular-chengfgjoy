//
//  PageViewController.swift
//  Weather Gift
//
//  Created by cheng jiayi on 2020/3/18.
//  Copyright © 2020 cheng jiayi. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
     var weatherLocations: [WeatherLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        loadFunctions()
        setViewControllers([createLocationDetailViewController(forPage: 0)], direction: .forward, animated: false, completion: nil)
       
    }
    func loadFunctions(){
          guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherLocations") as? Data else{
              print("Warning: cannot load.")
            weatherLocations.append(WeatherLocation(name: "Current Location", latitude: 20.20, longtitude: 20.20))
              return
          }
          let decoder = JSONDecoder()
          if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as [WeatherLocation]{
              self.weatherLocations = weatherLocations
          }else{
              print("Error: Cannot load")
          }
        if weatherLocations.isEmpty{
             weatherLocations.append(WeatherLocation(name: "Current Location", latitude: 20.20, longtitude: 20.20))
        }
      }
    
    func createLocationDetailViewController(forPage page: Int) -> LocationDetailViewController{
        let detailViewController = storyboard!.instantiateViewController(identifier: "LocationDetailViewController") as! LocationDetailViewController
        detailViewController.locationIndex = page
        return detailViewController
    }

   

}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? LocationDetailViewController{
            if currentViewController.locationIndex > 0{
                return createLocationDetailViewController(forPage: currentViewController.locationIndex-1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
         if let currentViewController = viewController as? LocationDetailViewController{
            if currentViewController.locationIndex < weatherLocations.count - 1{
                       return createLocationDetailViewController(forPage: currentViewController.locationIndex+1)
                   }
               }
               return nil
    }
    
    
}
