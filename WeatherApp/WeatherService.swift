//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Patrick Bellot on 11/22/17.
//  Copyright © 2017 Polestar Interactive LLC. All rights reserved.
//

import Foundation

class WeatherService {
  
  private init() {}
  static let shared = WeatherService()
  
  func getWeather(forCity: String) {
    guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(forCity)&APPID=ba639933d32f48c47d197ac099fa0ec4")  else { return }
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, error) in
  
      guard let data = data else { return }
      
      do {
        let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
        print(currentWeather)
      } catch {
        print("Error: \(error)")
      }
    } .resume()
  }
  
  
  
}// end of class
