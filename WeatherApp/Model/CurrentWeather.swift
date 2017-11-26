//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Patrick Bellot on 11/22/17.
//  Copyright © 2017 Polestar Interactive LLC. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
  let list: [List]
}

struct List: Decodable {
  let name: String
  let main: Main
  let weather: [Weather]
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

struct Weather: Decodable {
  let main: String
  let description: String
  let icon: String
}

extension Main {
  
  var tempFahrenheit: Int {
    return temp.fahrenheit()
  }
  
  var hiTempFarenheit: Int {
    return hiTemp.fahrenheit()
  }
  
  var loTempFarenheit: Int {
    return loTemp.fahrenheit()
  }
}

extension Float {
  func fahrenheit() -> Int {
    let fahrenheit = (self * 9 / 5) - 459.67
    return Int(fahrenheit)
  }
}

