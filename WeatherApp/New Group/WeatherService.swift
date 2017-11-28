//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Patrick Bellot on 11/26/17.
//  Copyright © 2017 Polestar Interactive LLC. All rights reserved.
//

import Foundation

enum APIError: Error {
  case apiError
  case responseError
  case jsonDecoder
  case unknown
}

class WeatherService {
  
  private init() {}
  static let shared = WeatherService()
  
  var weatherDidUpdateNotification: ((_ result: Any?) -> ())?
  
  func getWeather(forCity: String) {
    guard let url = URL(string: "http://api.openweathermap.org/data/2.5/find?q=\(forCity)&units=imperial&APPID=ba639933d32f48c47d197ac099fa0ec4") else { return }
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, error) in
      guard error == nil else {
        print("Error: \(APIError.apiError)")
        return
      }
      guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
        print("Error: \(APIError.responseError)")
        return
      }
      guard let data = data else { return }
      do {
        let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
        print(currentWeather)
        DispatchQueue.main.async {
          self.weatherDidUpdateNotification?(currentWeather)
        }
      } catch {
        print("Error: \(APIError.jsonDecoder)")
        DispatchQueue.main.async {
          print(error)
        }
      }
      }.resume()
  }
  


} // end of class
