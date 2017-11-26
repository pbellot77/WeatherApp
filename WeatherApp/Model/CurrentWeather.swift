//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Patrick Bellot on 11/22/17.
//  Copyright © 2017 Polestar Interactive LLC. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
  let name: String
  let weather: [Weather]
  let main: Main
}

struct Weather: Decodable {
  let main: String
  let description: String
  let icon: String
}

struct Main: Decodable {
  let temp: Float
  let humidity: Float
  let hiTemp: Float
  let loTemp: Float
  
  private enum CodingKeys: String, CodingKey {
    case temp
    case humidity
    case hiTemp = "temp_max"
    case loTemp = "temp_min"
  }
}

extension Main {
  var tempFahrenheit: Int {
    return temp.fahrenheit()
  }
  
  var hiTempFahrenheit: Int {
    return hiTemp.fahrenheit()
  }
  
  var loTempFahrenheit: Int {
    return loTemp.fahrenheit()
  }
}

extension Float {
  func fahrenheit() -> Int {
    let fahrenheit = (self * 9 / 5) - 459.67
    return Int(fahrenheit)
  }
}

